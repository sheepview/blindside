package org.red5.samples.publisher.control.commands
{	 
	import com.adobe.cairngorm.control.CairngormEvent;	
	import org.red5.samples.publisher.control.PublisherController;
	

	public class PlayStreamCommand extends CairngormEvent 
	{			
		public var streamName : String;	
		public var enableVideo : Boolean;	
		public var enableAudio : Boolean;
					
		public function PlayStreamCommand(  streamName : String,
										 enableVideo : Boolean,
										 enableAudio : Boolean ) 
		{
			super( PublisherController.PLAY_STREAM_COMMAND );
			this.streamName = streamName;
			this.enableVideo = enableVideo;
			this.enableAudio = enableAudio;
		}
	}
}