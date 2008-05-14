package org.red5.samples.publisher.control.commands
{	 
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.red5.samples.publisher.control.PublisherController;
	
	public class ResumeStreamCommand extends CairngormEvent 
	{		
		public var stream : String;
			
		public function ResumeStreamCommand(stream : String) 
		{
			super( PublisherController.RESUME_STREAM_COMMAND );
			this.stream = stream;
		}
	}
}