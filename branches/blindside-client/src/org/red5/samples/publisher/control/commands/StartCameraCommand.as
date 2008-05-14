package org.red5.samples.publisher.control.commands
{	 
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.red5.samples.publisher.control.PublisherController;
	
	public class StartCameraCommand extends CairngormEvent 
	{	
		public var stream : String;
					
		public function StartCameraCommand(stream : String) 
		{
			super( PublisherController.START_CAMERA_COMMAND );
			
			this.stream = stream;
		}
		
	}
}