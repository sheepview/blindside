package org.blindsideproject.core.apps.chat.controller.handlers
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	import org.blindsideproject.core.apps.chat.controller.commands.PrivateChatCommand;
	import org.blindsideproject.core.apps.chat.model.ChatModelLocator;

	public class PrivateChatCommandHandler implements ICommand
	{
		private var model : ChatModelLocator = ChatModelLocator.getInstance();
		public function execute(cgCommand:CairngormEvent):void
		{

			var command : PrivateChatCommand = PrivateChatCommand( cgCommand );
			//var privateChatPanel : PrivateChat = new PrivateChat(command.userid);
			model.chatDelegate.openPrivateChatPanel(command.toUserid);
			
		}
		
	}
}