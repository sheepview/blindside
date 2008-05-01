package org.blindsideproject.core.apps.conference.controller.handlers
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	import org.blindsideproject.core.apps.conference.model.ConferenceModelLocator;
	import org.blindsideproject.core.apps.conference.controller.commands.LeaveCommand;
	
	public class LeaveCommandHandler implements ICommand
	{
		private var model : ConferenceModelLocator = ConferenceModelLocator.getInstance();		
		
		public function execute(cgCommand : CairngormEvent):void
		{
			var command : LeaveCommand = LeaveCommand(cgCommand);

			model.log.info("LeaveHandler::user");
			
			model.conferenceDelegate.leave();
		}		
	}
}