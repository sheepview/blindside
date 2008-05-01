package org.blindsideproject.chat.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.chat.control.ChatController;

	public class SendMessageEvent extends CairngormEvent
	{
		public var message:String;
		
		public function SendMessageEvent(message:String)
		{
			super(ChatController.EVENT_SEND_MESSAGE)
			this.message=message;
		}
	}
}