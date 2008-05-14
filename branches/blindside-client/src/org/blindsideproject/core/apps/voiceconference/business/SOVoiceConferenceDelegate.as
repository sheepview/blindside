package org.blindsideproject.core.apps.voiceconference.business
{
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
		
	import flash.net.SharedObject;
	import flash.events.NetStatusEvent;
	import flash.events.AsyncErrorEvent;
	import flash.events.SyncEvent;
	import mx.rpc.events.AbstractEvent;	
	import flash.net.NetConnection;
	import org.blindsideproject.core.apps.voiceconference.model.VoiceConference;
	
	public class SOVoiceConferenceDelegate
	{
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		
		private var _conference : VoiceConference;
		private var _connection : NetConnection;
		private var _participantsSO : SharedObject;
		private var _ncDelegate : NetConnectionDelegate;
		
		private static const SO_NAME : String = "VOICE_USERS_SO";
		
		public function SOVoiceConferenceDelegate(conference : VoiceConference)
		{
			_conference = conference;	
		}
						
		public function join(host : String, room : String) : void
		{
			_connection = new NetConnection();
			_connection.client = this;
			
			_conference.host = host;
			_conference.room = room;
			
			_ncDelegate = new NetConnectionDelegate(this);
			_ncDelegate.connect(host, room);
		}
		
		public function get netConnection() : NetConnection
		{
			return _connection;
		}
		
		public function disconnected(reason : String) : void
		{
			_conference.connected = false;
			_conference.connectFailReason = reason;
		}
		
		public function connected() : void
		{
			_conference.connected = true;
			_conference.connectFailReason = null;
			
			joinConference();
		}
		
		private function joinConference() : void
		{
			// Start with a fresh list
			_conference.removeAllUsers();
			
			_participantsSO = SharedObject.getRemote(SO_NAME, _conference.host, false);
			
			_participantsSO.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_participantsSO.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			_participantsSO.addEventListener(SyncEvent.SYNC, sharedObjectSyncHandler);
			
			_participantsSO.client = this;

			_participantsSO.connect(_connection);
		}

		public function leave() : void
		{
			removeListeners();
			_participantsSO.close();
			_ncDelegate.disconnect();
			
			// Cleanup list of participants
			_conference.removeAllUsers();		
		}

		private function removeListeners() : void
		{
			_participantsSO.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_participantsSO.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			_participantsSO.removeEventListener(SyncEvent.SYNC, sharedObjectSyncHandler);
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
			switch (code)
			{
				case "clear":
					/** From flash.events.SyncEvent doc
					 * 
					 * A value of "clear" means either that you have successfully connected 
					 * to a remote shared object that is not persistent on the server or the 
					 * client, or that all the properties of the object have been deleted -- 
					 * for example, when the client and server copies of the object are so 
					 * far out of sync that Flash Player resynchronizes the client object 
					 * with the server object. In the latter case, SyncEvent.SYNC is dispatched 
					 * and the "code" value is set to "change". 
					 */
					 
					_conference.removeAllUsers();
													
					break;	
																			
				case "success":
					/** From flash.events.SyncEvent doc
					 * 	 A value of "success" means the client changed the shared object. 		
					 */
					
					// do nothing... just log it 
					log.debug( "Conference::success =[" + name + "," 
							+ _participantsSO.data[name].status + ","
							+ _participantsSO.data[name].hasStream
							+ "]");	
					break;

				case "reject":
					/** From flash.events.SyncEvent doc
					 * 	A value of "reject" means the client tried unsuccessfully to change the 
					 *  object; instead, another client changed the object.		
					 */
					
					// do nothing... just log it 
					// Or...maybe we should check if the value is the same as what we wanted it
					// to be..if not...change it?
					log.debug( "Conference::reject =[" + code + "," + name + "," + oldValue + "]");	
					break;

				case "change":
					/** From flash.events.SyncEvent doc
					 * 	A value of "change" means another client changed the object or the server 
					 *  resynchronized the object.  		
					 */
					 
					if (name != null) {						
						if (_conference.hasUser(_participantsSO.data[name].userid)) {

																					
						} else {

	
						}
						
					} else {
						log.warn( "Conference::SO::change is null");
					}
																	
					break;

				case "delete":
					/** From flash.events.SyncEvent doc
					 * 	A value of "delete" means the attribute was deleted.  		
					 */
					
					log.debug( "Conference::delete =[" + code + "," + name + "," + oldValue + "]");	
					
					// The participant has left. Cast name (string) into a Number.
					_conference.removeUser(Number(name));
					break;
										
				default:	
					log.debug( "Conference::default[" + _participantsSO.data[name].userid
									+ "," + _participantsSO.data[name].name + "]");		 
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
	}
}