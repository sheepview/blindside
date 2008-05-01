package org.blindsideproject.core.apps.conference.business
{
	import mx.rpc.IResponder;
	import flash.net.SharedObject;
	import flash.events.NetStatusEvent;
	import flash.events.AsyncErrorEvent;
	import flash.events.SyncEvent;
	import mx.collections.ArrayCollection;
	import mx.rpc.events.AbstractEvent;

	import com.adobe.cairngorm.control.CairngormEventDispatcher;
		
	import org.blindsideproject.core.apps.conference.model.ConferenceModelLocator;
	import org.blindsideproject.core.apps.conference.model.ConferenceModel;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.apps.conference.controller.events.DisconnectedEvent;
	import org.blindsideproject.core.apps.conference.controller.events.StatusChangeEvent;
	import org.blindsideproject.core.apps.conference.controller.events.ConferenceEvents;
	import org.blindsideproject.core.apps.conference.vo.Role;
	import org.blindsideproject.core.apps.conference.vo.User;
	import org.blindsideproject.core.apps.conference.controller.events.ConnectedEvent;
 				
	public class ConferenceDelegate
	{
		public static const ID : String = "ConferenceDelegate";
		
		private var model : ConferenceModelLocator = ConferenceModelLocator.getInstance();
		private var log : ILogger = model.log;
		private var dispatcher : CairngormEventDispatcher = model.dispatcher;
		
		private static const PARTICIPANTS : String = "PARTICIPANTS";
		
		public var conference : ConferenceModel = model.conference;
		
		private var participantsSO : SharedObject;
		private var connDelegate : NetConnectionDelegate;
				
		public function ConferenceDelegate()
		{
			connDelegate = new NetConnectionDelegate(this);
		}		
		
		public function set userId(value : Number) : void
		{
			conference.me.userid = value;
		}
		
		public function set role(value : String) : void
		{
			if (value == "MODERATOR")
				conference.me.role = Role.MODERATOR;
			else conference.me.role = Role.PARTICIPANT;
			
			log.debug("userid and role = [" + conference.me.userid + "," + conference.me.role + "]");
		}
		
		public function connectionSuccess() : void
		{
			conference.connected = true;
			
			sendConnectedEvent();
			
			joinConference();
		}
			
		public function connectionFailed(message : String) : void 
		{
			if (participantsSO != null) participantsSO.close();
			
			conference.connected = false;
			
			sendDisconnectedEvent(message);
		}		
		
		public function join(host : String, username : String, password : String, room : String) : void
		{			
			conference.me.username = username;
			conference.host = host;	
			conference.room = room;
					
			connDelegate.connect(host, room, username, password);
		}
		
		public function leave() : void
		{
			logout();			
		}
		
		private function joinConference() : void
		{
			log.debug("confUri=[" + connDelegate.connUri + "]");
			
			participantsSO = SharedObject.getRemote("participantsSO", connDelegate.connUri, false);
			
			participantsSO.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			participantsSO.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			participantsSO.addEventListener(SyncEvent.SYNC, sharedObjectSyncHandler);
			
			participantsSO.client = this;

			participantsSO.connect(connDelegate.getConnection());
		}

		private function removeListeners() : void
		{
			participantsSO.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			participantsSO.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			participantsSO.removeEventListener(SyncEvent.SYNC, sharedObjectSyncHandler);
		}		
		
		public function sendNewStatus(newStatus : String) : void {
			conference.me.status = newStatus;
			
			participantsSO.send("newStatus", conference.me.userid, 
					newStatus);
		}
				
		private function logout() : void
		{			
			removeListeners();
			participantsSO.close();
			connDelegate.disconnect();
			conference.close();
		}
		
		public function getConference() : ConferenceModel
		{
			return conference;
		}
		
		public function newStatus(userid : Number, status : String) : void
		{
			log.debug("Changing status from [" + userid + "]" +
						" [" + status + "]");

			conference.newUserStatus(userid, status);
			sendNewUserStatusEvent(userid, status);
			
		}
		
		private function sharedObjectSyncHandler( event : SyncEvent) : void
		{
			log.debug( "Conference::sharedObjectSyncHandler " + event.changeList.length);
			
			for (var i : uint = 0; i < event.changeList.length; i++) 
			{
				log.debug( "Conference::handlingChanges[" + event.changeList[i].name + "][" + i + "]");
				handleChangesToSharedObject(event.changeList[i].code, 
						event.changeList[i].name, event.changeList[i].oldValue);
			}
		}

		/**
		 * See flash.events.SyncEvent
		 */
		private function handleChangesToSharedObject(code : String, name : String, oldValue : Object) : void
		{
			switch (name)
			{
				case PARTICIPANTS:
					var users : Array = participantsSO.data.PARTICIPANTS as Array;
					
					log.debug( "PARTICIPANTS = [" + users.length + "]");
					
					conference.removeAllParticipants();
					
					for (var i : uint = 0; i < users.length; i++) {
						log.debug( "PARTICIPANT[" + i + "," + 
							users[i].userid + "," + 
							users[i].name + "," + users[i].role + "]");
				
						var newuser : User = new User();
						newuser.userid = users[i].userid;
						newuser.username = users[i].name;
//						newuser.status = status;
						newuser.role = Role.PARTICIPANT;
						
						if (users[i].role == "MODERATOR") {
							newuser.role = Role.MODERATOR;							
						}
						conference.addUser(newuser);
					}
								
					break;
															
				default:
					log.debug( "Conference::default =[" + code + "," + name + "," + oldValue + "]");				 
					break;
			}
		}
		
		private function netStatusHandler ( event : NetStatusEvent ) : void
		{
			log.debug( "Conference::netStatusHandler " + event.info.code );
		}
		
		private function asyncErrorHandler ( event : AsyncErrorEvent ) : void
		{
			log.debug( "Conference::asyncErrorHandler " + event.error);
		}
		
		public function sendNewUserStatusEvent(userid : Number, newStatus : String):void
		{
			var event : StatusChangeEvent = 
					new StatusChangeEvent(ConferenceEvents.STATUS_CHANGE_EVENT,
						userid, newStatus);
			dispatcher.dispatchEvent(event);
		}		
		
		public function sendConnectedEvent() : void
		{
			var event : ConnectedEvent = new ConnectedEvent(ConferenceEvents.CONNECTED_EVENT);
			
			event.dispatch();
		}

		public function sendDisconnectedEvent(message : String):void
		{
			var event : DisconnectedEvent = new DisconnectedEvent(ConferenceEvents.DISCONNECTED_EVENT,
												message);
			dispatcher.dispatchEvent(event);
		}
	}
}