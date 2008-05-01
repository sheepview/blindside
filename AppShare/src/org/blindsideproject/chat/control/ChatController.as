package org.blindsideproject.chat.control
{
	import com.adobe.cairngorm.control.FrontController;
	import org.blindsideproject.chat.command.*;
	
	

	public class ChatController extends FrontController
	{
		
		public static const EVENT_SEND_MESSAGE : String = "EVENT_SEND_MESSAGE";
		public static const EVENT_GET_MESSAGE : String = "EVENT_GET_MESSAGE";
		
		public function ChatController():void
		{
		addCommand( ChatController.EVENT_SEND_MESSAGE, SendMessageCommand );
		addCommand( ChatController.EVENT_GET_MESSAGE, GetMessageCommand );
		}
	}
}