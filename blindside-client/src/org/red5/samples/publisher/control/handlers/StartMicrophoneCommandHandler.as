package org.red5.samples.publisher.control.handlers 
{		 
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
		
	import flash.events.*;
	import flash.media.*;
	import flash.net.NetStream;
	
	import org.red5.samples.publisher.control.commands.StartMicrophoneCommand;
	import org.red5.samples.publisher.model.*;
	import org.red5.samples.publisher.vo.BroadcastMedia;

	public class StartMicrophoneCommandHandler implements ICommand 
	{			
		private var model : PublisherModel = PublisherModelLocator.getInstance().model;
	 		 		 	
	 	private var microphone : Microphone;
	 		
	 	public function execute( cgEvent : CairngormEvent ) : void
	    { 
			var cmd : StartMicrophoneCommand = StartMicrophoneCommand( cgEvent );
			var streamName : String = cmd.stream;
			
			var media : BroadcastMedia = model.getBroadcastMedia(streamName) as BroadcastMedia;			
			
			var selectedMicIndex : int = 	media.audio.settings.micIndex;
			var gain : int = 				media.audio.settings.gain;
			var rate : int = 				media.audio.settings.rate;
			var level : int = 				media.audio.settings.level;
			var timeout : int = 			media.audio.settings.timeout;
			var micIndex : int = 			selectedMicIndex - 1;
			
			media.audio.mic = Microphone.getMicrophone( micIndex );
			microphone = media.audio.mic;
			
			microphone.setLoopBack( true );
			
			var transform : SoundTransform = microphone.soundTransform;
			transform.volume = 0;
			
			microphone.setUseEchoSuppression( true );
			microphone.soundTransform = transform;
			microphone.gain = gain;
			microphone.rate = rate;
			microphone.setSilenceLevel( level, timeout );
			
			microphone.addEventListener( ActivityEvent.ACTIVITY, activityEventHandler );
			microphone.addEventListener( StatusEvent.STATUS, statusEventHandler );
			
			// update audio stream when we're already publishing.
			if ( media.broadcastStreamDelegate.nsPublish != null ) 
			{
				media.broadcastStreamDelegate.nsPublish.attachAudio( microphone );
				media.deviceStarted = true;
			}
			
			 
			//log.debug( "StartMicrophoneCommand::Started audio device <b>" + microphone.name + "</b>" );
		}
			
		private function activityEventHandler( event : ActivityEvent ) : void 
		{
//			log.debug( "StartMicrophoneCommand::activityEventHandler: " + event );
		}
		
		private function statusEventHandler( event : StatusEvent ) : void 
		{
//			log.debug( "StartMicrophoneCommand::statusEventHandler: " + event );
		}
		
	}
}