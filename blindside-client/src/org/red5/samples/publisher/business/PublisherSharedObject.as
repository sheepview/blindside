package org.red5.samples.publisher.business
{
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
			
	import mx.rpc.IResponder;
	import mx.collections.ArrayCollection;
	
	public class PublisherSharedObject implements IResponder
	{
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		
		private var streams : ArrayCollection;		
		
		[Bindable] public var connected : Boolean;
				
		public function PublisherSharedObject() 
		{
			streams = new ArrayCollection();
		}
		
		public function fault(  event : Object  ) : void {
			
		}
				
		public function addStream(name : String) : void
		{
			streams.addItem(name);
		}
		
		public function get numberOfStreams() : Number
		{
			return streams.length;
		}
		
		public function hasStream(name : String) : Boolean
		{
			return streams.contains(name);
		}
		
		public function removeStream(name : String) : void
		{
			var index : Number = streams.getItemIndex(name);
			if (index != -1) streams.removeItemAt(index);
		}

		public function result(  event : Object  ) : void {
			var info : Object = event.info;
			var statusCode : String = info.code;
			
			connected = false;
			
			switch ( statusCode ) 
			{
				case "NetConnection.Connect.Success" :
					
					connected = true;

					// find out if it's a secure (HTTPS/TLS) connection
					if ( event.target.connectedProxyType == "HTTPS" || event.target.usingTLS ) {
						log.info( 	"Connected to secure server" );
					} else {
						log.info(	"Connected to server");
					}
					break;
			
				case "NetConnection.Connect.Failed" :

					log.info(	"Connection to server failed");
					break;
					
				case "NetConnection.Connect.Closed" :

					log.info(	"Connection to server closed" );
					break;
					
				case "NetConnection.Connect.InvalidApp" :
					
					log.info(	"Application not found on server");
					break;
					
				case "NetConnection.Connect.AppShutDown" :
					
					log.info(	"Application has been shutdown");
					break;
					
				case "NetConnection.Connect.Rejected" :
					
					log.info(	"No permissions to connect to the application");
					break;
					
				default :
				   // statements
				   break;
			}
		}
	}
}