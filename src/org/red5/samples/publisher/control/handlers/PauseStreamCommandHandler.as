package org.red5.samples.publisher.control.handlers 
{	
	 
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.red5.samples.publisher.control.commands.PauseStreamCommand;
	import org.red5.samples.publisher.model.*;
	import org.red5.samples.publisher.vo.PlayMedia;
	
	public class PauseStreamCommandHandler implements ICommand 
	{
		private var model : PublisherModel = PublisherModelLocator.getInstance().model;
		 	 	
	 	public function execute( cgEvent : CairngormEvent ) : void
	    { 
	    	var cmd : PauseStreamCommand = PauseStreamCommand( cgEvent );
	    	var media : PlayMedia = model.getPlayMedia(cmd.stream) as PlayMedia;
	    	
	    	// Use Delegate to pause NetStream.
	      	media.playStreamDelegate.pausePlayback();
		}
	}
}