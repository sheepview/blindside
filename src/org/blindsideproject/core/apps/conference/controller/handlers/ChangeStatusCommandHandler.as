package org.blindsideproject.core.apps.conference.controller.handlers
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	import org.blindsideproject.core.apps.conference.controller.commands.ChangeStatusCommand;
	import org.blindsideproject.core.apps.conference.model.ConferenceModelLocator;
		
	public class ChangeStatusCommandHandler implements ICommand
	{		
		private var model : ConferenceModelLocator = ConferenceModelLocator.getInstance();
		
		public function execute(cgCommand:CairngormEvent) : void
		{
			var command : ChangeStatusCommand = ChangeStatusCommand(cgCommand);
			
			model.conferenceDelegate.sendNewStatus(command.getNewStatus());
			
		}
		
		
	}
}