package org.red5.samples.publisher.control.handlers 
{		 
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerFacade;
		
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;
	
	import mx.rpc.IResponder;
	
	import org.red5.samples.publisher.business.*;
	import org.red5.samples.publisher.control.commands.SetupConnectionCommand;
	import org.red5.samples.publisher.model.*;
	import org.red5.samples.publisher.view.general.Images;
	
	public class SetupConnectionCommandHandler implements ICommand
	{		
		private var modelLoc : PublisherModelLocator = PublisherModelLocator.getInstance();
	 	 	
	 	public function execute( cgEvent : CairngormEvent ) : void
	    {
			var cmd : SetupConnectionCommand = SetupConnectionCommand( cgEvent );
			modelLoc.netConnDelegate = new NetworkConnectionDelegate( );
		}
	}
}