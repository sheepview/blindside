package org.blindsideproject.core.apps.chat.controller.handlers
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	import org.blindsideproject.core.apps.chat.model.ChatModelLocator;
	import org.blindsideproject.core.apps.chat.controller.commands.LeaveCommand;
	
	public class LeaveCommandHandler implements ICommand
	{
		private var model : ChatModelLocator = ChatModelLocator.getInstance();		
		
		public function execute(cgCommand : CairngormEvent):void
		{
			var command : LeaveCommand = LeaveCommand(cgCommand);

			model.log.info("LeaveCommandHandler::execute()");
			
			model.chatDelegate.leave();
		}		
	}
}