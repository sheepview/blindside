package org.blindsideproject.core.apps.chat.controller.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.chat.controller.ChatController;

	public class SendMessageCommand extends CairngormEvent
	{
		public var _message:String;
		
		
		public function SendMessageCommand(message:String):void
		{
			super(ChatController.EVENT_SEND_MESSAGE);
			_message = message;
		}
		
		public function getMessage():String
		{
			return _message;
		}
	}
}