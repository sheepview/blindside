package org.red5.samples.publisher.control.commands
{	 
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.red5.samples.publisher.control.PublisherController;
	
	public class StopStreamCommand extends CairngormEvent 
	{		
		public var stream : String;
		
		public function StopStreamCommand(stream : String) 
		{
			super( PublisherController.STOP_STREAM_COMMAND );
			this.stream = stream;
		}
	}
}