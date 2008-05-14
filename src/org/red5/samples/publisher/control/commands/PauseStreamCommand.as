package org.red5.samples.publisher.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.red5.samples.publisher.control.PublisherController;
	
	public class PauseStreamCommand extends CairngormEvent 
	{		
		public var stream : String;
			
		public function PauseStreamCommand(streamName : String) 
		{
			super( PublisherController.PAUSE_STREAM_COMMAND );
			stream = streamName;
		}
	}
}