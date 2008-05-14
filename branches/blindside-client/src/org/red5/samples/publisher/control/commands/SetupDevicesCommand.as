package org.red5.samples.publisher.control.commands
{

	import com.adobe.cairngorm.control.CairngormEvent;
	import org.red5.samples.publisher.control.PublisherController;
	

	public class SetupDevicesCommand extends CairngormEvent 
	{	
		public function SetupDevicesCommand() 
		{
			super( PublisherController.SETUP_DEVICES_COMMAND );
		}
	}
}