package org.blindsideproject.core.apps.chat.controller.handlers
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	import org.blindsideproject.core.apps.chat.model.ChatModelLocator;
	import org.blindsideproject.core.apps.chat.controller.commands.JoinCommand;
	
		
	public class JoinCommandHandler implements ICommand
	{		
		private var model : ChatModelLocator = ChatModelLocator.getInstance();
				
		public function execute(cgCommand:CairngormEvent):void
		{
			var command : JoinCommand = JoinCommand(cgCommand);
	        model.chatDelegate.join(command.host, command.room);
		}
	}
}