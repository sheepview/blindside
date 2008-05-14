package org.blindsideproject.core.apps.conference.controller.handlers
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	import org.blindsideproject.core.apps.conference.controller.commands.BroadcastStreamCommand;
	import org.blindsideproject.core.apps.conference.model.ConferenceModelLocator;
		
	public class BroadcastStreamCommandHandler implements ICommand
	{		
		private var model : ConferenceModelLocator = ConferenceModelLocator.getInstance();
		
		public function execute(cgCommand:CairngormEvent) : void
		{
			var command : BroadcastStreamCommand = BroadcastStreamCommand(cgCommand);
			
			model.conferenceDelegate.sendBroadcastStream(command.hasStream, command.streamName);
			
		}
		
		
	}
}