package org.red5.samples.publisher.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.red5.samples.publisher.control.PublisherController;
	
	public class EnableVideoCommand extends CairngormEvent 
	{	
		public var stream : String;	
		public var enable : Boolean;
		
		public function EnableVideoCommand(stream : String,  enable : Boolean ) 
		{
			super( PublisherController.ENABLE_VIDEO_COMMAND );
			this.stream = stream;
			this.enable = enable;
		}
	}
}