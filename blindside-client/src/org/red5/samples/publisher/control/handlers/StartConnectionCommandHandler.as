package org.red5.samples.publisher.control.handlers 
{		 
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.red5.samples.publisher.control.commands.StartConnectionCommand;
	import org.red5.samples.publisher.model.*;
	import org.red5.samples.publisher.business.*;
	
	public class StartConnectionCommandHandler implements ICommand 
	{		
		private var modelLoc : PublisherModelLocator = PublisherModelLocator.getInstance();	 	 	
	 		
	 	private var netConnectionDelegate : NetworkConnectionDelegate = modelLoc.netConnDelegate;
	 	 	
	 	public function execute ( cgEvent : CairngormEvent ) : void
	    { 
			var cmd : StartConnectionCommand = StartConnectionCommand( cgEvent );
			var uri : String = 		cmd.uri;
			var proxy : String = 	cmd.proxy;
			var encoding : uint = 	cmd.encoding;
			// Use Delegate to create a connection to the RTMP server.
	      	netConnectionDelegate.connect( uri, proxy, encoding );
		}
		
	}
}