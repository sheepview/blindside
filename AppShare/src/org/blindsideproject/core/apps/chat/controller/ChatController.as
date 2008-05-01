package org.blindsideproject.core.apps.chat.controller
{
	import com.adobe.cairngorm.control.FrontController;
	import org.blindsideproject.core.apps.chat.controller.handlers.*;
	
	

	public class ChatController extends FrontController
	{
		public static const ID : String = "org.blindsideproject.core.apps.chat.contoller.ChatController";
		
		public static const EVENT_SEND_MESSAGE : String = "EVENT_SEND_MESSAGE";
		public static const JOIN_COMMAND : String = "CHAT_JOIN_COMMAND";
		public static const LEAVE_COMMAND : String = "CHAT_LEAVE_COMMAND";
		public static const PRIVATE_CHAT_COMMAND : String = "PRIVATE_CHAT_COMMAND";
		public static const PRIVATE_MESSAGE_COMMAND : String = "PRIVATE_MESSAGE_COMMAND";
		
		public function ChatController():void
		{
		addCommand( ChatController.EVENT_SEND_MESSAGE, SendMessageCommandHandler );
		addCommand(ChatController.JOIN_COMMAND, JoinCommandHandler);
		addCommand(ChatController.LEAVE_COMMAND, LeaveCommandHandler);
		addCommand(ChatController.PRIVATE_CHAT_COMMAND, PrivateChatCommandHandler);
		addCommand(ChatController.PRIVATE_MESSAGE_COMMAND, PrivateMessageCommandHandler);
		}
	}
}