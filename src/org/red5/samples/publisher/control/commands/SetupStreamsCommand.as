package org.red5.samples.publisher.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;	
	import org.red5.samples.publisher.control.PublisherController;
	
	public class SetupStreamsCommand extends CairngormEvent 
	{
		public var streamName : String;
		
		public function SetupStreamsCommand(streamName : String) 
		{
			super( PublisherController.SETUP_STREAMS_COMMAND );
			this.streamName = streamName;
		}
		
	}
}