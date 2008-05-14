package org.red5.samples.publisher.control.commands
{	 
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.red5.samples.publisher.control.PublisherController;
	
	public class CloseConnectionCommand extends CairngormEvent 
	{
		public function CloseConnectionCommand() 
		{
			super( PublisherController.CLOSE_CONNECTION_COMMAND );
		}
	}
}