package org.red5.samples.publisher.control.commands
{	 
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.red5.samples.publisher.control.PublisherController;
	
	public class SetupConnectionCommand extends CairngormEvent 
	{
		public function SetupConnectionCommand() 
		{
			super( PublisherController.SETUP_CONNECTION_COMMAND );
		}
	}
}