package org.blindsideproject.core.apps.conference.business
{
	import org.blindsideproject.core.apps.conference.model.ConferenceModelLocator;
	import mx.rpc.IResponder;
	import flash.net.NetConnection;
	import flash.events.*;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerFacade;
		
	public class NetConnectionDelegate2
	{
		public static const ID : String = "CONFERENCE.NetConnectionDelegate";
		
		private var model : ConferenceModelLocator = ConferenceModelLocator.getInstance();
		private var log : ILogger = LoggerFacade.getInstance().log;
		
		private var responder : ConferenceDelegate;
				
		private var netConnection : NetConnection;	
		private var _connUri : String;
		private var connectionId : Number;
		private var connected : Boolean = false;
					
		public function NetConnectionDelegate2(responder : ConferenceDelegate) : void
		{
			this.responder = responder;
		}

/*		public function join(username : String, password : String, room : String) : void
		{
			connect(uri);	
		}
*/		

		public function get connUri() : String
		{
			return _connUri;
		}
		
		public function connect(host : String , room : String, 
					username : String, password : String) : void
		{		
			netConnection = new NetConnection();			
			netConnection.client = this;
			
			netConnection.addEventListener( NetStatusEvent.NET_STATUS, netStatus );
			netConnection.addEventListener( AsyncErrorEvent.ASYNC_ERROR, netASyncError );
			netConnection.addEventListener( SecurityErrorEvent.SECURITY_ERROR, netSecurityError );
			netConnection.addEventListener( IOErrorEvent.IO_ERROR, netIOError );
			
			try {
//				if (uri.charAt(uri.length) == "/")
//				{
//					_connUri = uri + room;
//				} else {
//					_connUri = uri + "/" + room;
//				}	
				
				_connUri = "rtmp://" + host + "/blindside/" + room;
				
				log.info( "Connecting to <b>" + _connUri + "</b>");
				
				netConnection.connect(_connUri, room, username, password );
				
			} catch( e : ArgumentError ) {
				// Invalid parameters.
				switch ( e.errorID ) 
				{
					case 2004 :						
						log.error( "Invalid server location: <b>" + _connUri + "</b>");											   
						break;						
					default :
					   break;
				}
			}	
		}
			
		public function disconnect() : void
		{
			netConnection.close();
		}
					
		protected function netStatus( event : NetStatusEvent ) : void 
		{
			handleResult( event );
		}
		
		public function handleResult(  event : Object  ) : void {
			var info : Object = event.info;
			var statusCode : String = info.code;
			
			switch ( statusCode ) 
			{
				case "NetConnection.Connect.Success" :
					responder.connectionSuccess();
					
					// find out if it's a secure (HTTPS/TLS) connection
					if ( event.target.connectedProxyType == "HTTPS" || event.target.usingTLS ) {
						log.info( 	"Connected to secure server");
					} else {
						log.info(	"Connected to server");
					}
					break;
			
				case "NetConnection.Connect.Failed" :
					
					responder.connectionFailed(event.info.application);
					
					responder.connectionFailed("Connection to server failed.");
					
					log.info("Connection to server failed");
					break;
					
				case "NetConnection.Connect.Closed" :					
					responder.connectionFailed("Connection to server closed.");					
					log.info("Connection to server closed");
					break;
					
				case "NetConnection.Connect.InvalidApp" :				
					responder.connectionFailed("Application not found on server")
					log.info("Application not found on server");
					log.info(event.info.application + ":");
					break;
					
				case "NetConnection.Connect.AppShutDown" :
				
					responder.connectionFailed("Application has been shutdown");
					log.info("Application has been shutdown");
					break;
					
				case "NetConnection.Connect.Rejected" :
					responder.connectionFailed(event.info.application);
					log.info("No permissions to connect to the application" );
					break;
					
				default :
				   // statements
				   break;
			}
		}
		
			
		protected function netSecurityError( event : SecurityErrorEvent ) : void 
		{
		    handleFault( new SecurityErrorEvent ( SecurityErrorEvent.SECURITY_ERROR, false, true,
		    										  "Security error - " + event.text ) );
		}
		
		protected function netIOError( event : IOErrorEvent ) : void 
		{
			handleFault( new IOErrorEvent ( IOErrorEvent.IO_ERROR, false, true, 
							 "Input/output error - " + event.text ) );
		}
			
		protected function netASyncError( event : AsyncErrorEvent ) : void 
		{
			handleFault( new AsyncErrorEvent ( AsyncErrorEvent.ASYNC_ERROR, false, true,
							 "Asynchronous code error - <i>" + event.error + "</i>" ) );
		}
	
		public function handleFault(  event : Object  ) : void 
		{			
			responder.connectionFailed(event.text);
		}
		
		public function getConnection() : NetConnection
		{
			return netConnection;
		}
		
		public function setId(id:Number ) : *
		{
			log.debug( ID + "::setConnectionId: id=[" + id + "]");
			if( isNaN( id ) ) return "FAILED";
			
			connectionId = id;
			
			return "OK";			
		}

		/**
	 	*  Callback setConnectionId from server
	 	*/
		public function setUserIdAndRole(id : Number, role : String ) : String
		{
			log.debug( ID + "::setConnectionId: id=[" + id + "]");
			if( isNaN( id ) ) return "FAILED";
			
			connectionId = id;
			
			responder.userId = id;
			responder.role = role;
			
			return "OK";
		}	
		
		public function getConnectionId() : Number
		{
			return connectionId;
		}
	}
}