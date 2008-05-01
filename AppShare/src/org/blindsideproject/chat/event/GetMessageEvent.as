package org.blindsideproject.chat.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.chat.control.ChatController;

	public class GetMessageEvent extends CairngormEvent
	{
		public var name:String;
		public var message:String;
		
		public function GetMessageEvent(message:String, name:String)
		{
			super(ChatController.EVENT_GET_MESSAGE)
			this.message=message;
			this.name=name;
		}
	}
}