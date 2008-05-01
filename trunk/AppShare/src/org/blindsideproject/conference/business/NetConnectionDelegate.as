package org.blindsideproject.conference.business
{
	import org.blindsideproject.conference.model.Conference;
	import org.blindsideproject.conference.model.ConferenceModelLocator;
	import mx.rpc.IResponder;
	import flash.net.NetConnection;
	import flash.events.*;
	import org.blindsideproject.util.components.logger.model.Logger;
		
	public class NetConnectionDelegate
	{
		private var model : ConferenceModelLocator = ConferenceModelLocator.getInstance();
		private var log : Logger = model.getLogger();
		
		private var responder : IResponder;		
		private var netConnection : NetConnection;	
		private var conference : Conference;
		private var connectionId : Number;
					
		public function NetConnectionDelegate(conference : Conference)
		{
			this.conference = conference;
			responder = new ConferenceConnectResponder(conference);
			conference.setConnectionDelegate(this);
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
				
				log.info( "Connecting to <b>" + conference.getUri() + "</b>");
				
				// Create connection with the server. 
				// TODO: must pass username and password here to authenticate
				netConnection.connect( conference.getUri(), true );
			} catch( e : ArgumentError ) {
				// Invalid parameters.
				switch ( e.errorID ) 
				{
					case 2004 :						
						log.error( "Invalid server location: <b>" + conference.getUri() + "</b>");											   
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
		public function setId( id:Number ):*
		{
			log.debug( "NetconnectionDelegate::setId: id=" + id );
			if( isNaN( id ) ) return;
			connectionId = id;
			return "Okay";
		}	
		
		public function getClientId() : Number
		{
			return connectionId;
		}
		
		public function getUri() : String{
			return conference.getUri();
		}	
		
		public function getConnection() : NetConnection
		{
			return netConnection;
		}
		
		public function sendNewStatus() : void
		{
			ConferenceConnectResponder(responder).sendNewStatus();
		}
	}
}