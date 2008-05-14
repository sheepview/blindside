package org.red5.samples.publisher.control.handlers 
{		 
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.red5.samples.publisher.control.commands.PlayStreamCommand;
	import org.red5.samples.publisher.model.*;
	import org.red5.samples.publisher.vo.PlayMedia;
	
	public class PlayStreamCommandHandler implements ICommand 
	{
			
		private var model : PublisherModel = PublisherModelLocator.getInstance().model;
	 	
 	 	
	 	public function execute( cgEvent : CairngormEvent ) : void
	    { 
	    	var cmd : PlayStreamCommand = PlayStreamCommand( cgEvent );
	    	
	    	var streamName : String = cmd.streamName;
	    	var enableVideo : Boolean = cmd.enableVideo;
	    	var enableAudio : Boolean = cmd.enableAudio;
	    	
	    	var media : PlayMedia = model.getPlayMedia(cmd.streamName) as PlayMedia;
	    	
	    	var bufferTime : int = model.generalSettings.bufferTime;
	    	
			// Use Delegate to playback the NetStream.
	      	media.playStreamDelegate.startPlayback( bufferTime, streamName, enableVideo, enableAudio );
		}
				
	}
}