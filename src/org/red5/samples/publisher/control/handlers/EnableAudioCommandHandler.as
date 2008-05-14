package org.red5.samples.publisher.control.handlers 
{	
	 
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.red5.samples.publisher.control.commands.EnableAudioCommand;
	import org.red5.samples.publisher.model.*;
	import org.red5.samples.publisher.vo.PlayMedia;
	
	public class EnableAudioCommandHandler implements ICommand 
	{			
		private var model : PublisherModel = PublisherModelLocator.getInstance().model;
	  	 	
	 	public function execute( cgEvent : CairngormEvent ) : void
	    { 
	    	var cmd : EnableAudioCommand = EnableAudioCommand( cgEvent );
	    	var media : PlayMedia = model.getPlayMedia(cmd.streamName) as PlayMedia;
	    	
			// Use Delegate to control the audio of the NetStream.
	      	media.playStreamDelegate.enableAudio( cmd.enable );
		}
				
	}
}