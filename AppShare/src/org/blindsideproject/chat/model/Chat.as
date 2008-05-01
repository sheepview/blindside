package org.blindsideproject.chat.model
{
	import flash.net.*;
	import org.blindsideproject.chat.business.ChatDelegate;
	
	public class Chat
	{
		public var nc : NetConnection;
		public var chatDelegate : ChatDelegate;
		public var uri : String = "rtmp://localhost/SOSample";
		
		public function Chat()
		{
								
		}
		
		public function setupConnection() : void
		{
			chatDelegate = new ChatDelegate(uri);
		}
	}
}