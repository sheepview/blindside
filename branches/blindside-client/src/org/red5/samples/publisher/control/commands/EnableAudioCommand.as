package org.red5.samples.publisher.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.red5.samples.publisher.control.PublisherController;
	
	public class EnableAudioCommand extends CairngormEvent 
	{	
		public var streamName : String;
		public var enable : Boolean;
		
	
		public function EnableAudioCommand( streamName : String, enable : Boolean ) 
		{
			super( PublisherController.ENABLE_AUDIO_COMMAND );
			this.streamName = streamName;
			this.enable = enable;
		}
	}
}