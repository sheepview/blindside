package org.red5.samples.publisher.control.commands
{

	import com.adobe.cairngorm.control.CairngormEvent;	
	import org.red5.samples.publisher.control.PublisherController;
	

	public class PublishStreamCommand extends CairngormEvent 
	{		
		public var publishMode : String;	
		public var streamName : String;
		

		public function PublishStreamCommand( publishMode : String, streamName : String ) 
		{
			super( PublisherController.PUBLISH_STREAM_COMMAND );
			this.publishMode = publishMode;
			this.streamName = streamName;
		}
	}
}