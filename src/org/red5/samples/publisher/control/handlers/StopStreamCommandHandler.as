package org.red5.samples.publisher.control.handlers 
{	
	 
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.red5.samples.publisher.control.commands.StopStreamCommand;
	import org.red5.samples.publisher.model.*;
	import org.red5.samples.publisher.vo.PlayMedia;
	
	public class StopStreamCommandHandler implements ICommand 
	{
		private var model : PublisherModel = PublisherModelLocator.getInstance().model; 
			 	
	 	public function execute( cgEvent : CairngormEvent ) : void
	    { 
	    	var cmd : StopStreamCommand = StopStreamCommand( cgEvent );
	    	var media : PlayMedia = model.getPlayMedia(cmd.stream) as PlayMedia;
	    	
	    	// Use Delegate to close NetStream.
	      	media.playStreamDelegate.stopPlayback();
		}
	}
}