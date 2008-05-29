package org.bigbluebutton.modules.meetme.model.business
{
	import flash.events.*;
	import flash.net.NetConnection;
	
	import org.bigbluebutton.modules.meetme.MeetMeFacade;
	import org.bigbluebutton.modules.meetme.model.MeetMeRoom;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
		
	/**
	 *  This is the NetConnectionDelegate which connects to the server
	 * <p>
	 * This class extends the Proxy Class of the PureMVC framework
	 * @author Richard Alam
	 * 
	 */	
	public class NetConnectionDelegate extends Proxy implements IProxy
	{
		public static const NAME:String = "NetConnectionDelegate";
		
		private var model:MeetMeFacade = MeetMeFacade.getInstance();
		private var log : ILogger = LoggerModelLocator.getInstance().log;
			
		private var netConnection : NetConnection;	
		private var meetmeRoom : MeetMeRoom;
		private var roomNumber : String;
					
		/**
		 * The Default constructor 
		 * @param meetmeRoom - the MeetMeRoom this class uses
		 * 
		 */					
		public function NetConnectionDelegate(meetmeRoom:MeetMeRoom)
		{
			super(NAME);
			this.meetmeRoom = meetmeRoom;
			meetmeRoom.setConnectionDelegate(this);
		}
		
		/**
		 *  
		 * @return - the MeetMeConnectResponder of this class
		 * 
		 */		
		public function get responder():MeetMeConnectResponder{
			return facade.retrieveProxy(MeetMeConnectResponder.NAME) as MeetMeConnectResponder;
		}

		/**
		 * Attempts connect to the server 
		 * 
		 */
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
		 * Closes the connection to the server
		 * 
		 */		
		public function close() : void
		{
			// Close the NetConnection.
			responder.close();
			netConnection.close();
		}
				
		/**
		 * This method gets called when a NET_STATUS event is received from the server
		 * @param event
		 */		
		protected function netStatus( event : NetStatusEvent ) : void 
		{
			this.responder.result( event );
		}
		
		/**
		 * This method gets called when a NET_SECURITY_ERROR is received from the server
		 * @param event
		 */		
		protected function netSecurityError( event : SecurityErrorEvent ) : void 
		{
		    responder.fault( new SecurityErrorEvent ( SecurityErrorEvent.SECURITY_ERROR, false, true,
		    										  "Security error - " + event.text ) );
		}
		
		/**
		 * This method gets called when an IO_ERROR event is received from the server
		 * @param event
		 */		
		protected function netIOError( event : IOErrorEvent ) : void 
		{
			responder.fault( new IOErrorEvent ( IOErrorEvent.IO_ERROR, false, true, 
							 "Input/output error - " + event.text ) );
		}
		
		/**
		 * This method gets called when an ASYNC_ERROR event is received from the server
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
		
		/**
		 *  
		 * @return the URI of the MeetMeRoom
		 * 
		 */		
		public function getUri() : String{
			return meetmeRoom.getUri();
		}	
		
		/**
		 * 
		 * @return the NetConnection of this class
		 * 
		 */		
		public function getConnection() : NetConnection
		{
			return netConnection;
		}
		
		/**
		 * Send a call to the server to mute all users 
		 * @param muteUSers
		 * 
		 */		
		public function muteAllUsers(muteUSers : Boolean) : void 
		{
			responder.muteAllUsers(muteUSers);
			
		}
		
		/**
		 * Mute or Unmute a specific user 
		 * @param userId - the user to mute/unmute
		 * @param muteUser - mute/unmute?
		 * 
		 */		
		public function muteUnmuteUser(userId : Number, muteUser : Boolean) : void
		{
			log.debug("NetConnectionDelegate::muteUnmuteUser : [" + userId + "," + muteUser + "]");
			
			responder.muteUnmuteUser(userId, muteUser);
		}

		/**
		 * Ejects a particular user 
		 * @param userId - the user to eject
		 * 
		 */
		public function ejectUser(userId : Number) : void
		{
			log.debug("NetConnectionDelegate::ejectUser : [" + userId + "]");
			
			responder.ejectUser(userId);
		}
	}
}