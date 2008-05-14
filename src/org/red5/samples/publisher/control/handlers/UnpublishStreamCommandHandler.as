package org.red5.samples.publisher.control.handlers 
{	
	 
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.red5.samples.publisher.control.commands.UnpublishStreamCommand;
	import org.red5.samples.publisher.model.*;
	import org.red5.samples.publisher.vo.BroadcastMedia;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
	
	public class UnpublishStreamCommandHandler implements ICommand 
	{		
		private var model : PublisherModel = PublisherModelLocator.getInstance().model;
	 	private var log : ILogger = LoggerModelLocator.getInstance().log;
	 		 	
	 	public function execute( cgEvent : CairngormEvent ) : void
	    { 
	    	var cmd : UnpublishStreamCommand = UnpublishStreamCommand( cgEvent );
	    	var streamName : String = cmd.stream;
	    	
	    	log.info("Unpublishing stream[" + streamName + "]");
	    	
	    	var media : BroadcastMedia = model.getBroadcastMedia(streamName) as BroadcastMedia;
	    				
			// Use Delegate to publish the NetStream.
	      	media.broadcastStreamDelegate.stopPublish();
		}
				
	}
}