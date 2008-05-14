package org.red5.samples.publisher.control.commands
{
	 
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.red5.samples.publisher.control.PublisherController;
	
	public class UnpublishStreamCommand extends CairngormEvent 
	{	
		public var stream : String;
			
		public function UnpublishStreamCommand(streamName : String) 
		{
			super( PublisherController.UNPUBLISH_STREAM_COMMAND );
			stream = streamName;
		}
		
	}
}