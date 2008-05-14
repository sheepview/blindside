package org.blindsideproject.core.apps.chat.controller.handlers
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	import org.blindsideproject.core.apps.chat.controller.commands.SendMessageCommand;
    import org.blindsideproject.core.apps.chat.business.*;

    import org.blindsideproject.core.apps.chat.model.*;

	public class SendMessageCommandHandler implements ICommand
	{
		private var model : ChatModelLocator = ChatModelLocator.getInstance();
		
		//private var name:String;
		//private var message:String;
		
		public function execute(cgCommand:CairngormEvent):void
		{
			var command : SendMessageCommand = SendMessageCommand(cgCommand);
			//message = command.getMessage();
			model.chatDelegate.sendMessage(command.getMessage());			
		}    //command.getMessage()      
	}
}