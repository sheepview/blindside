package org.blindsideproject.core.apps.conference.controller.handlers
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	
	import org.blindsideproject.core.apps.conference.model.ConferenceModelLocator;
	import org.blindsideproject.core.apps.conference.model.ConferenceModel;
	import org.blindsideproject.core.apps.conference.controller.commands.JoinCommand;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.conference.events.ConferenceJoinEvent;
		
	import mx.rpc.IResponder;

		
	public class JoinCommandHandler implements ICommand
	{		
		private var model : ConferenceModelLocator = ConferenceModelLocator.getInstance();

		public function execute(cgCommand:CairngormEvent):void
		{
			var command : JoinCommand = JoinCommand(cgCommand);
	
			model.conferenceDelegate.join(command.host, command.username,
						command.password, command.room);
		}
	}
}