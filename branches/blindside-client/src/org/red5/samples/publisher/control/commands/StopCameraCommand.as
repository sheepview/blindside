package org.red5.samples.publisher.control.commands
{
	 
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.red5.samples.publisher.control.PublisherController;
	
	public class StopCameraCommand extends CairngormEvent 
	{		
		public var stream : String;
		
		public function StopCameraCommand(stream : String) 
		{
			super( PublisherController.STOP_CAMERA_COMMAND );
			
			this.stream = stream;
		}		
	}
}