package org.red5.samples.publisher.control.handlers 
{	
	 
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
		
	import flash.events.*;
	
	import org.red5.samples.publisher.model.*;
	import org.red5.samples.publisher.control.commands.StopMicrophoneCommand;
	import org.red5.samples.publisher.vo.BroadcastMedia;
	
	public class StopMicrophoneCommandHandler implements ICommand 
	{	
		private var model : PublisherModel = PublisherModelLocator.getInstance().model;
		private var log : ILogger = LoggerModelLocator.getInstance().log;
	
	 	public function execute( cgEvent : CairngormEvent ) : void
	    { 		
	    	var cmd : StopMicrophoneCommand = StopMicrophoneCommand(cgEvent);
	    	var media : BroadcastMedia = model.getBroadcastMedia(cmd.stream) as BroadcastMedia;
	    	
	    	log.debug("Stopping microphone[" + cmd.stream + "]");

			if (media == null) {
				log.debug("Stopping microphone[" + cmd.stream + "] with media NULL");
			}
				    	
			// disconnect mic
			if ( media.audio.mic != null ) 
			{
				media.audio.mic.setLoopBack( false );
				
				media.broadcastStreamDelegate.stopMicrophone();
				media.deviceStarted = false;
			}
			
			log.debug( "StopMicrophoneCommand::Disabled audio device" );
		}
	}
}