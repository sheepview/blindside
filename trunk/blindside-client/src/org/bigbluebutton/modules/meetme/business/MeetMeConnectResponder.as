package org.bigbluebutton.modules.meetme.business
{
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SyncEvent;
	import flash.net.Responder;
	import flash.net.SharedObject;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	
	import org.bigbluebutton.modules.meetme.model.MeetMeFacade;
	import org.bigbluebutton.modules.meetme.model.MeetMeRoom;
	import org.bigbluebutton.modules.meetme.vo.MeetMeUser;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
			
	public class MeetMeConnectResponder extends Proxy implements IResponder, IProxy
	{
		public static const NAME:String = "MeetMeConnectResponder";
		
		private var model:MeetMeFacade = MeetMeFacade.getInstance();
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		
		private var meetMeRoom : MeetMeRoom;
		private var participantsSO : SharedObject;
		private var participants : Array;
				
		public function MeetMeConnectResponder(meetMeRoom:MeetMeRoom)
		{
			super(NAME);
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
			participantsSO.connect(meetMeRoom.getConnection().getConnection());			
		}

		public function userJoin(userId : Number, cidName : String, cidNum : String, 
									muted : Boolean, talking : Boolean) : void
		{
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
					participants[i].isMuted = mute;					
					sendNewMeetMeEvent();
				}
			}			
		}

		public function userTalk(userId : Number, talk : Boolean) : void
		{
			log.debug("User Talking");
			if (participants == null) return;
			
			for (var i:int = 0; i < participants.length; i++)
			{
				if (participants[i].userid == userId) {
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
					meetMeRoom.dpParticipants.removeItemAt(i);		
				}
			}	
			
			meetMeRoom.dpParticipants.refresh();	
		}
		
		public function newStatus(user:MeetMeUser) : void {
//			log.debug("MeetMe::newStatus : [" + user.callerIdName + "," + user.userNumber + "]");
		}

		public function currentUsers(users : Object) : void {
		}
		
		public function sendEjectUserFromMeetMe() : void {

		}
		
		public function muteUnmuteUser(userId : Number, muteUser : Boolean) : void
		{
			var nc_responder : Responder;
			nc_responder = new Responder(getMeetMeUsers, null);
					
			log.info("MeetMe: calling meetmeService.muteUnmuteUser");
			meetMeRoom.getConnection().getConnection().call("meetmeService.muteUnmuteUser", nc_responder, userId, muteUser);			
		}

		public function muteAllUsers(mute : Boolean) : void
		{	
			log.info("MeetMe: calling meetmeService.muteAllUsers");
			meetMeRoom.getConnection().getConnection().call("meetmeService.muteAllUsers", null, mute);			
		}

		public function ejectUser(userId : Number) : void
		{
			log.info("MeetMe: calling meetmeService.ejectUser");
			meetMeRoom.getConnection().getConnection().call("meetmeService.ejectUser", null, userId);			
		}
		
		public function getMeetMeUsers(meetmeUser : Object) : void
		{
			var i:Number = 0;
			
			if (participants == null) participants = new Array();
							
			for(var items:String in meetmeUser) 
			{
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
			
			log.debug("Getting users for refresh");
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
			log.debug("Got to sendMeetMeEvent");
			//var event : NewMeetMeEvent = 
			//		new NewMeetMeEvent(MeetMeEvents.USER_JOIN_EVENT);
			//dispatcher.dispatchEvent(event);
			sendNotification(MeetMeFacade.USER_JOIN_EVENT);
		}		
	}
}