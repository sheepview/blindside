package org.blindsideproject.meetme.business
{
	import org.blindsideproject.meetme.model.MeetMeRoom;
	import org.blindsideproject.meetme.model.MeetMeModelLocator;
	import mx.rpc.IResponder;
	import flash.net.NetConnection;
	import flash.events.*;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
		
	public class NetConnectionDelegate
	{
		private var model : MeetMeModelLocator = MeetMeModelLocator.getInstance();
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		
		private var responder : MeetMeConnectResponder;		
		private var netConnection : NetConnection;	
		private var meetmeRoom : MeetMeRoom;
		private var roomNumber : String;
					
		public function NetConnectionDelegate(meetmeRoom : MeetMeRoom)
		{
			this.meetmeRoom = meetmeRoom;
			responder = new MeetMeConnectResponder(meetmeRoom);
			meetmeRoom.setConnectionDelegate(this);
		}

		public function connect() : void
		{		
			netConnection = new NetConnection();
			
			netConnection.client = this;
			
			// Setup the NetConnection and listen for NetStatusEvent and SecurityErrorEvent events.
			netConnection.addEventListener( NetStatusEvent.NET_STATUS, netStatus );
			netConnection.addEventListener( AsyncErrorEvent.ASYNC_ERROR, netASyncError );
			netConnection.addEventListener( SecurityErrorEvent.SECURITY_ERROR, netSecurityError );
			netConnection.addEventListener( IOErrorEvent.IO_ERROR, netIOError );
			
			// connect to server
			try {
				
				log.info( "Connecting to <b>" + meetmeRoom.getUri() + "</b>");

				netConnection.connect( meetmeRoom.getUri(), true );
			} catch( e : ArgumentError ) {
				// Invalid parameters.
				switch ( e.errorID ) 
				{
					case 2004 :						
						log.error( "Invalid server location: <b>" + meetmeRoom.getUri() + "</b>");											   
						break;
						
					default :
					   //
					   break;
				}
			}	
		}
		
		/**
		 * 
		 * 
		 */		
		public function close() : void
		{
			// Close the NetConnection.
			responder.close();
			netConnection.close();
		}
				
		/**
		 * 
		 * @param event
		 */		
		protected function netStatus( event : NetStatusEvent ) : void 
		{
			this.responder.result( event );
		}
		
		/**
		 * 
		 * @param event
		 */		
		protected function netSecurityError( event : SecurityErrorEvent ) : void 
		{
		    responder.fault( new SecurityErrorEvent ( SecurityErrorEvent.SECURITY_ERROR, false, true,
		    										  "Security error - " + event.text ) );
		}
		
		/**
		 * 
		 * @param event
		 */		
		protected function netIOError( event : IOErrorEvent ) : void 
		{
			responder.fault( new IOErrorEvent ( IOErrorEvent.IO_ERROR, false, true, 
							 "Input/output error - " + event.text ) );
		}
		
		/**
		 * 
		 * @param event
		 */		
		protected function netASyncError( event : AsyncErrorEvent ) : void 
		{
			responder.fault( new AsyncErrorEvent ( AsyncErrorEvent.ASYNC_ERROR, false, true,
							 "Asynchronous code error - <i>" + event.error + "</i>" ) );
		}
		
		/**
	 	*  Callback setID from server
	 	*/
		public function setRoomNumber( room : String ):*
		{
			log.debug( "NetconnectionDelegate::setRoomNumber:room = " + room );
			roomNumber = room;
			
			return "Okay";
		}	
		
//		public function getClientId() : Number
//		{
//			return connectionId;
//		}
		
		public function getUri() : String{
			return meetmeRoom.getUri();
		}	
		
		public function getConnection() : NetConnection
		{
			return netConnection;
		}
		
		public function muteAllUsers(muteUSers : Boolean) : void 
		{
			responder.muteAllUsers(muteUSers);
			
		}
		public function muteUnmuteUser(userId : Number, muteUser : Boolean) : void
		{
			log.debug("NetConnectionDelegate::muteUnmuteUser : [" + userId + "," + muteUser + "]");
			
			responder.muteUnmuteUser(userId, muteUser);
		}

		public function ejectUser(userId : Number) : void
		{
			log.debug("NetConnectionDelegate::ejectUser : [" + userId + "]");
			
			responder.ejectUser(userId);
		}
	}
}