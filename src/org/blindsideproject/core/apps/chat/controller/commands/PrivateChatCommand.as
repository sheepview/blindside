package org.blindsideproject.core.apps.chat.controller.commands
{   
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.chat.controller.ChatController;
	public class PrivateChatCommand extends CairngormEvent
	{
		private var _toUserid : Number;
		
		public function PrivateChatCommand(toUserid : Number) : void
		{
			super(ChatController.PRIVATE_CHAT_COMMAND);
			_toUserid = toUserid;
		}
		public function get toUserid() : Number
		{
			return _toUserid;
		}	
	}
}