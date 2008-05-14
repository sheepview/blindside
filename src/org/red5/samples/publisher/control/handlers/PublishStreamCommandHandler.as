package org.red5.samples.publisher.control.handlers 
{
	 	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.red5.samples.publisher.control.commands.PublishStreamCommand;
	import org.red5.samples.publisher.model.*;
	import org.red5.samples.publisher.vo.BroadcastMedia;
	
	public class PublishStreamCommandHandler implements ICommand 
	{		
		private var model : PublisherModel = PublisherModelLocator.getInstance().model;
	 		 		 	 	
	 	public function execute( cgEvent : CairngormEvent ) : void
	    { 
	    	var cmd : PublishStreamCommand = PublishStreamCommand( cgEvent );
	    	var publishMode : String = cmd.publishMode;
	    	var streamName : String = cmd.streamName;
	    	
	    	var media : BroadcastMedia = model.getBroadcastMedia(streamName) as BroadcastMedia;
	    				
			// Use Delegate to publish the NetStream.
	      	media.broadcastStreamDelegate.startPublish( publishMode, streamName );
		}
				
	}
}