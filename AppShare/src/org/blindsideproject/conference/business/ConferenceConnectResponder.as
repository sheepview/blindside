package org.blindsideproject.conference.business
{
	import mx.rpc.IResponder;

	import org.blindsideproject.conference.model.ConferenceModelLocator;
	import org.blindsideproject.conference.model.Conference;
	import org.blindsideproject.util.components.logger.model.Logger;
	import org.blindsideproject.conference.events.ConferenceJoinEvent;
	import org.blindsideproject.conference.events.DisconnectedEvent;
	import org.blindsideproject.conference.events.NewUserStatusChangeEvent;
	import org.blindsideproject.conference.control.ConferenceEvents;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import flash.net.SharedObject;
	import flash.events.NetStatusEvent;
	import flash.events.AsyncErrorEvent;
	import flash.events.SyncEvent;
	import org.blindsideproject.conference.vo.ParticipantVo;
	import mx.collections.ArrayCollection;
			
	public class ConferenceConnectResponder implements IResponder
	{
		private var model : ConferenceModelLocator = ConferenceModelLocator.getInstance();
		private var log : Logger = model.getLogger();
		private var dispatcher : CairngormEventDispatcher = model.getDispatcher();
		
		private var conference : Conference;
		private var participantsSO : SharedObject;
		private var participants : Array;
				
		public function ConferenceConnectResponder(conference : Conference)
		{
			this.conference = conference;

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

			conference.isConnected = false;

			switch ( statusCode ) 
			{
				case "NetConnection.Connect.Success" :
					//
					conference.isConnected = true;

					// We have successfully connected. Add the conference to the manager.
					model.getConferenceManager().setConference(conference);
	
					conference.sendConnectedEvent();
					joinConference();
					
					// find out if it's a secure (HTTPS/TLS) connection
					if ( event.target.connectedProxyType == "HTTPS" || event.target.usingTLS ) {
						log.info( 	"Connected to secure server");
					} else {
						log.info(	"Connected to server");
					}
					break;
			
				case "NetConnection.Connect.Failed" :
					
					serverDisconnect(DisconnectedEvent.FAILED, "Connection to server failed");
					
					log.info("Connection to server failed");
					break;
					
				case "NetConnection.Connect.Closed" :
					
					serverDisconnect(DisconnectedEvent.CLOSED, "Connection to server closed");
					
					log.info("Connection to server closed");
					break;
					
				case "NetConnection.Connect.InvalidApp" :
					serverDisconnect(DisconnectedEvent.INVALID_APP, "Application not found on server")
					log.info("Application not found on server");
					break;
					
				case "NetConnection.Connect.AppShutDown" :
					serverDisconnect(DisconnectedEvent.APP_SHUTDOWN, "Application has been shutdown");
					log.info("Application has been shutdown");
					break;
					
				case "NetConnection.Connect.Rejected" :
					serverDisconnect(DisconnectedEvent.REJECTED, "No permissions to connect to the application");
					log.info("No permissions to connect to the application" );
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
			if (participantsSO != null) participantsSO.close();
			
			conference.sendDisconnectedEvent(reason, message);
		}		
		
		private function joinConference() : void
		{

			participantsSO = SharedObject.getRemote("participantsSO", conference.getConnection().getUri(), true);
			participantsSO.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			participantsSO.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			participantsSO.addEventListener(SyncEvent.SYNC, sharedObjectSyncHandler);
			
			participantsSO.client = this;

			participantsSO.connect(conference.getConnection().getConnection());
			
			participantsSO.send("getParticipants");
		}
		
		public function sendNewStatus() : void {
			participantsSO.send("newStatus", conference.getConnection().getClientId(), 
					conference.getUserStatus());
		}
		
		public function newStatus(userId : Number, status : String) : void
		{
			if (participants == null) return;
			
			for (var i:int = 0; i < participants.length; i++)
			{
				if (participants[i].userid == userId) {
					
					log.debug("Changing status from [" + participants[i].userstatus + "]" +
						" to [" + status + "]");
					participants[i].userstatus = status;
					
					sendNewUserStatusEvent(userId, status);
				}
			}			
		}
		
		public function getParticipants() : void
		{
			log.info( "GetParticipants " );
			
			participants = new Array();

			participantsSO.send( "newParticipant", conference.getUsername(), conference.getRole(),
				conference.getUserStatus(), conference.getConnection().getClientId());			
		}
	
		public function newParticipant(name : String, role : uint, status : String, userId : Number) : void
		{
			log.debug("Got newParticipants message = [" + role + "," + status + "," + name + "," + userId + "]");
			
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
					log.debug("New user : [" + role + "," + status + "," + name + "," + userId + "]"); 
					participants.push({username : name, userrole : role, userstatus : status, userid : userId});
				}
				
				participants.sortOn("username", Array.CASEINSENSITIVE);
				
				conference.dpParticipants = new ArrayCollection(participants);
		}
		
		private function sharedObjectSyncHandler( event : SyncEvent) : void
		{
			log.debug( "sharedObjectSyncHandler " + event.changeList);
		}
		
		private function netStatusHandler ( event : NetStatusEvent ) : void
		{
			log.debug( "netStatusHandler " + event.info.code );
		}
		
		private function asyncErrorHandler ( event : AsyncErrorEvent ) : void
		{
			log.debug( "asyncErrorHandler " + event.error);
		}
		
		public function sendNewUserStatusEvent(userid : Number, newStatus : String):void
		{
			var event : NewUserStatusChangeEvent = 
					new NewUserStatusChangeEvent(ConferenceEvents.NEW_USER_STATUS_EVENT,
						userid, newStatus);
			dispatcher.dispatchEvent(event);
		}		
	}
}