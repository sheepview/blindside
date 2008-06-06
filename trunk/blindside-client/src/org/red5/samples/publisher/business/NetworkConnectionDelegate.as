package org.red5.samples.publisher.business
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerFacade;
		
	import flash.events.*;
	import flash.net.*;
	
	import mx.rpc.IResponder;
	
	import org.red5.samples.publisher.model.*;
	import org.red5.samples.publisher.view.general.Images;			
	
	public class NetworkConnectionDelegate
	{	
		[Bindable]
		public var model : PublisherModel = PublisherModelLocator.getInstance().model;				
			
		private var netConnection : NetConnection;
			
		public function NetworkConnectionDelegate()
		{			
		}
		
		public function get connection() : NetConnection
		{
			return netConnection;
		}	
		
		public function connect( uri : String, proxy : String, encoding : uint ) : void
		{			
			netConnection = new NetConnection();			
			netConnection.client = this;			
			netConnection.objectEncoding = encoding;
			netConnection.proxyType = proxy;
			
			netConnection.addEventListener( NetStatusEvent.NET_STATUS, netStatus );
			netConnection.addEventListener( AsyncErrorEvent.ASYNC_ERROR, netASyncError );
			netConnection.addEventListener( SecurityErrorEvent.SECURITY_ERROR, netSecurityError );
			netConnection.addEventListener( IOErrorEvent.IO_ERROR, netIOError );
			
			try {				
				//log.debug("NetConnection::Connecting to <b>" + uri + "</b>");
				netConnection.connect( uri );
			}
			catch( e : ArgumentError ) 
			{
				// Invalid parameters.
				switch ( e.errorID ) 
				{
					case 2004 :
						//log.error( "NetConnection::Invalid server location: <b>" + uri + "</b>");
						break;
						
					default :
					   //
					   break;
				}
			}	
		}
			
		public function close() : void
		{
			netConnection.close();
		}
					
		protected function netStatus( event : NetStatusEvent ) : void 
		{
			handleResult( event );
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
	
		public function handleResult(  event : Object  ) : void {
			var info : Object = event.info;
			var statusCode : String = info.code;
			
			//log.debug( "NetworkConnectionDelegate::" + statusCode );
			
			model.connected = false;
			
			switch ( statusCode ) 
			{
				case "NetConnection.Connect.Success" :
					
					model.connected = true;
					
					// find out if it's a secure (HTTPS/TLS) connection
					if ( event.target.connectedProxyType == "HTTPS" || event.target.usingTLS ) {
						//log.info( "NetworkConnectionDelegate::Connected to secure server");
					} else {
						//log.info("NetworkConnectionDelegate::Connected to server");
					}
					break;
			
				case "NetConnection.Connect.Failed" :
					
					serverDisconnect();
					
					//log.warn("NetworkConnectionDelegate::Connection to server failed" );
					break;
					
				case "NetConnection.Connect.Closed" :
					
					serverDisconnect();
					
					//log.warn("NetworkConnectionDelegate::Connection to server closed");
					break;
					
				case "NetConnection.Connect.InvalidApp" :
					//log.warn("NetworkConnectionDelegate::Application not found on server" );
					break;
					
				case "NetConnection.Connect.AppShutDown" :
					//log.warn("NetworkConnectionDelegate::Application has been shutdown");
					break;
					
				case "NetConnection.Connect.Rejected" :
					//log.warn("NetworkConnectionDelegate::No permissions to connect to the application" );
					break;
					
				default :
				   // statements
				   break;
			}
		}
			
		public function handleFault(  event : Object  ) : void {
			//log.warn("NetworkConnectionDelegate::" + event.text );
		}
		
		/**
		 * The Red5 oflaDemo returns bandwidth stats.
		 */		
		public function onBWDone() : void {
			
		}
			
		private function serverDisconnect() : void 
		{
			model.connected = false;
		}


    }
}