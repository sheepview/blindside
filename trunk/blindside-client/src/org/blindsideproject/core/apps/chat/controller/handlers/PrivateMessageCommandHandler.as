package org.blindsideproject.core.apps.chat.controller.handlers
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	import org.blindsideproject.core.apps.chat.model.ChatModelLocator;
	import org.blindsideproject.core.apps.chat.controller.commands.PrivateMessageCommand;

	public class PrivateMessageCommandHandler implements ICommand
	{
		private var model : ChatModelLocator = ChatModelLocator.getInstance();
		
		public function execute(cgCommand:CairngormEvent):void
		{
			var command : PrivateMessageCommand = PrivateMessageCommand(cgCommand);
			//message = command.getMessage();
			model.chatDelegate.sendPrivateMessage(command.privateMessage ,
			command.fromUserid , command.toUserid , command.fromUsername , 
			command.toUsername , command.initiator);	
		}
		
	}
}