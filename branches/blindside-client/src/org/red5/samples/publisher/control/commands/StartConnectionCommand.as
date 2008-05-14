package org.red5.samples.publisher.control.commands
{	 
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.red5.samples.publisher.control.PublisherController;
	
	public class StartConnectionCommand extends CairngormEvent 
	{	
		public var uri : String;		
		public var proxy : String;	
		public var encoding : uint;

		public function StartConnectionCommand( uri : String,
											  proxy : String,
											  encoding : uint ) 
		{
			super( PublisherController.START_CONNECTION_COMMAND );
			this.uri = uri;
			this.proxy = proxy;
			this.encoding = encoding;
		}
	}
}