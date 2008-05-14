package org.red5.samples.publisher.control.commands
{
	 
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.red5.samples.publisher.control.PublisherController;
	
	public class StopMicrophoneCommand extends CairngormEvent 
	{	
		public var stream : String;
			
		public function StopMicrophoneCommand(stream : String) 
		{
			super( PublisherController.STOP_MICROPHONE_COMMAND );
			this.stream = stream;
		}
		
	}
}