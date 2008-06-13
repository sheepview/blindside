package org.bigbluebutton.modules.viewers.model.services
{
	import mx.rpc.IResponder;
	import flash.net.NetConnection;
	import flash.events.*;
		
	public class NetConnectionDelegate
	{
		public static const ID : String = "CONFERENCE::NetConnectionDelegate";
		
		private var _confDelegate : SharedObjectConferenceDelegate;
				
		private var _netConnection : NetConnection;	

					
		public function NetConnectionDelegate(confDelegate : SharedObjectConferenceDelegate) : void
		{
			_confDelegate = confDelegate;
		}
		
		public function connect(host : String , room : String, 
					username : String, password : String) : void
		{		
			_netConnection = _confDelegate.netConnection;
			
			_netConnection.addEventListener( NetStatusEvent.NET_STATUS, netStatus );
			_netConnection.addEventListener( AsyncErrorEvent.ASYNC_ERROR, netASyncError );
			_netConnection.addEventListener( SecurityErrorEvent.SECURITY_ERROR, netSecurityError );
			_netConnection.addEventListener( IOErrorEvent.IO_ERROR, netIOError );
			
			try {
				//log.info( "Connecting to <b>" + host + "</b>");
				
				_netConnection.connect(host, room, username, password );
				
			} catch( e : ArgumentError ) {
				// Invalid parameters.
				switch ( e.errorID ) 
				{
					case 2004 :						
						//log.error( "Invalid server location: <b>" + host + "</b>");											   
						break;						
					default :
					   break;
				}
			}	
		}
			
		public function disconnect() : void
		{
			_netConnection.close();
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
					_confDelegate.connected();
					
					// find out if it's a secure (HTTPS/TLS) connection
					if ( event.target.connectedProxyType == "HTTPS" || event.target.usingTLS ) {
						//log.info( 	"Connected to secure server");
					} else {
						//log.info(	"Connected to server");
					}
					break;
			
				case "NetConnection.Connect.Failed" :
					_confDelegate.disconnected("The connection to the server failed.");
					
					//log.info("Connection to server failed");
					break;
					
				case "NetConnection.Connect.Closed" :					
					_confDelegate.disconnected("The connection to the server closed.");					
					//log.info("Connection to server closed");
					break;
					
				case "NetConnection.Connect.InvalidApp" :				
					_confDelegate.disconnected("The application was not found on the server.")
					//log.info("Application not found on server");
					break;
					
				case "NetConnection.Connect.AppShutDown" :				
					_confDelegate.disconnected("The application has been shutdown.");
					//log.info("Application has been shutdown");
					break;
					
				case "NetConnection.Connect.Rejected" :
					_confDelegate.disconnected("No permission to connect to the application.");
					//log.info("No permissions to connect to the application" );
					break;
					
				default :
				   // statements
				   break;
			}
		}
		
			
		protected function netSecurityError( event : SecurityErrorEvent ) : void 
		{
		    handleFault( "Security error - " + event.text );
		}
		
		protected function netIOError( event : IOErrorEvent ) : void 
		{
			handleFault( "Input/output error - " + event.text );
		}
			
		protected function netASyncError( event : AsyncErrorEvent ) : void 
		{
			handleFault( "Asynchronous code error - " + event.error );
		}
	
		public function handleFault(  reason : String  ) : void 
		{			
			_confDelegate.disconnected(reason);
		}
	}
}