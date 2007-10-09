package org.blindsideproject.meetme.business
{
	import mx.rpc.IResponder;

	import org.blindsideproject.meetme.model.MeetMeModelLocator;
	import org.blindsideproject.meetme.model.MeetMeRoom;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;

	import org.blindsideproject.meetme.events.NewMeetMeEvent;
	import org.blindsideproject.meetme.events.MeetMeEvents;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import flash.net.SharedObject;
	import flash.events.NetStatusEvent;
	import flash.events.AsyncErrorEvent;
	import flash.events.SyncEvent;
	import mx.collections.ArrayCollection;
	import org.blindsideproject.meetme.vo.MeetMeUser;
	import flash.net.Responder;
			
	public class MeetMeConnectResponder implements IResponder
	{
		private var model : MeetMeModelLocator = MeetMeModelLocator.getInstance();
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		private var dispatcher : CairngormEventDispatcher = model.getDispatcher();
		
		private var meetMeRoom : MeetMeRoom;
		private var participantsSO : SharedObject;
		private var participants : Array;
				
		public function MeetMeConnectResponder(meetMeRoom : MeetMeRoom)
		{
			this.meetMeRoom = meetMeRoom;
		}		
		
		/**
		 * 
		 * The result method is called when the delegate receives 
		 * a result from the service
		 * 
		 * @param event
		 */		
		public function result(  event : Object  ) : void {
			var info : Object = event.info;
			var statusCode : String = info.code;
			
			log.info( statusCode);

			meetMeRoom.isConnected = false;

			switch ( statusCode ) 
			{
				case "NetConnection.Connect.Success" :
					//
					meetMeRoom.isConnected = true;

					meetMeRoom.sendConnectedEvent();
									
					// find out if it's a secure (HTTPS/TLS) connection
					if ( event.target.connectedProxyType == "HTTPS" || event.target.usingTLS ) {
						log.info("MeetMe:: Connected to secure server");
					} else {
						log.info("MeetMe: Connected to server");
					}
					
					joinMeetMeRoom();
					
					var nc_responder : Responder;
					nc_responder = new Responder(getMeetMeUsers, null);
					
					// call the server side method to get list of FLV's
				    meetMeRoom.getConnection().getConnection().call("meetmeService.getMeetMeUsers", nc_responder);
					
					break;
			
				case "NetConnection.Connect.Failed" :
					
//					serverDisconnect(DisconnectedEvent.FAILED, "Connection to server failed");
					
					log.info("MeetMe::Connection to server failed");
					break;
					
				case "NetConnection.Connect.Closed" :
					
//					serverDisconnect(DisconnectedEvent.CLOSED, "Connection to server closed");
					
					log.info("MeetMe::Connection to server closed");
					break;
					
				case "NetConnection.Connect.InvalidApp" :
//					serverDisconnect(DisconnectedEvent.INVALID_APP, "Application not found on server")
					log.info("MeetMe::Application not found on server");
					break;
					
				case "NetConnection.Connect.AppShutDown" :
//					serverDisconnect(DisconnectedEvent.APP_SHUTDOWN, "Application has been shutdown");
					log.info("MeetMe::Application has been shutdown");
					break;
					
				case "NetConnection.Connect.Rejected" :
//					serverDisconnect(DisconnectedEvent.REJECTED, "No permissions to connect to the application");
					log.info("MeetMe::No permissions to connect to the application" );
					break;
					
				default :
				   // statements
				   break;
			}
		}
		
		/**
		 * The fault method is called when the delegate receives a fault from the service
		 * 
		 * @param event
		 */		
		public function fault(  event : Object  ) : void {
			
			log.error( event.text);
		}
		
			
		private function serverDisconnect(reason : uint, message : String) : void 
		{
			close();
			
			meetMeRoom.sendDisconnectedEvent(reason, message);
		}		
		
		public function close() : void {
			if (participantsSO != null) participantsSO.close();
		}
		private function joinMeetMeRoom() : void
		{
			participantsSO = SharedObject.getRemote("meetMeUsersSO", meetMeRoom.getConnection().getUri(), false);
			participantsSO.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			participantsSO.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			participantsSO.addEventListener(SyncEvent.SYNC, sharedObjectSyncHandler);
			
			participantsSO.client = this;
			
			log.debug("MeetMe::Connecting to meetme shared object...");
			
			participantsSO.connect(meetMeRoom.getConnection().getConnection());			
		}

		public function userJoin(userId : Number, cidName : String, cidNum : String, 
									muted : Boolean, talking : Boolean) : void
		{
			log.debug("MeetMe::Got userJoin message = [" + userId + "," + 
					cidName + "," + cidNum + "," + muted + "," + talking + "]");
			
			if (participants == null) participants = new Array();
			
			// Only add new participants to our array
			var isNew : Boolean = true;
			for (var i:int = 0; i < participants.length; i++)
			{
				if (participants[i].userid == userId) {
					isNew = false;
				}
			}
				
			if (isNew) {
				if (cidName == null) cidName = "unknown";
				
				log.debug("MeetMe::New user : [" + cidName + "," + userId + "]"); 
				participants.push({callerName : cidName, isMuted : muted, isTalking : talking, userid : userId});
			}

			participants.sortOn("callerName", Array.CASEINSENSITIVE);
				
			meetMeRoom.dpParticipants = new ArrayCollection(participants);
			meetMeRoom.dpParticipants.refresh();
		}

		public function userMute(userId : Number, mute : Boolean) : void
		{
			if (participants == null) return;
			
			for (var i:int = 0; i < participants.length; i++)
			{
				if (participants[i].userid == userId) {
					
					log.debug("MeetMe::Changing mute from [" + participants[i].isMuted + "]" +
						" to [" + mute + "]");
					participants[i].isMuted = mute;
					
					sendNewMeetMeEvent();
				}
			}			
		}

		public function userTalk(userId : Number, talk : Boolean) : void
		{
			if (participants == null) return;
			
			for (var i:int = 0; i < participants.length; i++)
			{
				if (participants[i].userid == userId) {
					
					log.debug("MeetMe::Changing talk from [" + participants[i].isTalking + "]" +
						" to [" + talk + "]");
					participants[i].isTalking = talk;
					
					sendNewMeetMeEvent();
				}
			}			
		}

		public function userLeft(userId : Number) : void
		{
			if (participants == null) return;
			
			participants = meetMeRoom.dpParticipants.toArray();
			
			var currentUsers : Array = new Array();
			
			for (var i:int = 0; i < meetMeRoom.dpParticipants.length; i++)
			{
				if (meetMeRoom.dpParticipants[i].userid == userId) {
					log.debug("MeetMe::User is leaving = " + userId);			
					meetMeRoom.dpParticipants.removeItemAt(i);		
				}
			}	
			
			meetMeRoom.dpParticipants.refresh();	
		}
		
		public function newStatus(user : MeetMeUser) : void {
			log.debug("MeetMe::newStatus : [" + user.callerIdName + "," + user.userNumber + "]");
		}

		public function currentUsers(users : Object) : void {
//			var usersArray : Array = users;
			
			log.debug("MeetMe::currentUsers : [" + users[0].callerIdName + "," + users[0].userNumber + "]");
		}
		
		public function sendEjectUserFromMeetMe() : void {

		}
		
		public function muteUnmuteUser(userId : Number, muteUser : Boolean) : void
		{
			var nc_responder : Responder;
			nc_responder = new Responder(getMeetMeUsers, null);
			
			log.debug("MeetMe::muteUnmuteUser : [" + userId + "," + muteUser + "]");
					
			// call the server side method to get list of FLV's
			meetMeRoom.getConnection().getConnection().call("meetmeService.muteUnmuteUser", null, userId, muteUser);			
		}

		public function ejectUser(userId : Number) : void
		{

			log.debug("MeetMe::ejectUser : [" + userId + "]");
					
			// call the server side method to get list of FLV's
			meetMeRoom.getConnection().getConnection().call("meetmeService.ejectUser", null, userId);			
		}
		
		public function getMeetMeUsers(meetmeUser : Object) : void
		{
			log.debug("Got meetme current users. ");
			
			var i:Number = 0;
			
			if (participants == null) participants = new Array();
							
			for(var items:String in meetmeUser) 
			{
				log.debug("Item:" + i + ", Name:" + meetmeUser[items][0]
					+ ", Length:" + meetmeUser[items][1] + "\n");
					
				var userId : String = meetmeUser[items][0];
				var cidName : String = meetmeUser[items][1];	
				var cidNum : String  = meetmeUser[items][2];
				var muted : Boolean = meetmeUser[items][3];
				var talking : Boolean = meetmeUser[items][4];
				
				if (cidName == null) cidName = "unknown";
				
				participants.push({callerName : cidName, isMuted : muted, isTalking : talking, userid : userId});

				i++;
			}			

			participants.sortOn("callerName", Array.CASEINSENSITIVE);
				
			meetMeRoom.dpParticipants = new ArrayCollection(participants);
			meetMeRoom.dpParticipants.refresh();
		}
	
		public function newStatusForUser(status : String) : void {
			
		}	
			
		private function sharedObjectSyncHandler( event : SyncEvent) : void
		{
			log.debug( "MeetMe::sharedObjectSyncHandler " + event.changeList);
		}
		
		private function netStatusHandler ( event : NetStatusEvent ) : void
		{
			log.debug( "MeetMe::netStatusHandler " + event.info.code );
		}
		
		private function asyncErrorHandler ( event : AsyncErrorEvent ) : void
		{
			log.debug( "MeetMe::asyncErrorHandler " + event.error);
		}
		
		public function sendNewMeetMeEvent():void
		{
			var event : NewMeetMeEvent = 
					new NewMeetMeEvent(MeetMeEvents.USER_JOIN_EVENT);
			dispatcher.dispatchEvent(event);
		}		
	}
}