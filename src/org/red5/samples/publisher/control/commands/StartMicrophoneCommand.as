package org.red5.samples.publisher.control.commands
{
	 
	import com.adobe.cairngorm.control.CairngormEvent;	
	import org.red5.samples.publisher.control.PublisherController;
	
	public class StartMicrophoneCommand extends CairngormEvent 
	{
		public var stream : String;

		public function StartMicrophoneCommand(stream : String) 
		{
			super( PublisherController.START_MICROPHONE_COMMAND );
			
			this.stream = stream;
		}
	}
}