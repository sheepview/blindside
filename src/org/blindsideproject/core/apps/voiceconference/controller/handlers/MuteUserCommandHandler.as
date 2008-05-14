package org.blindsideproject.core.apps.voiceconference.controller.handlers
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	import org.blindsideproject.core.apps.voiceconference.model.VoiceConferenceModelLocator;
	import org.blindsideproject.core.apps.voiceconference.controller.commands.LeaveCommand;
	
	public class MuteUserCommandHandler implements ICommand
	{
		private var model : VoiceConferenceModelLocator = VoiceConferenceModelLocator.getInstance();		
		
		public function execute(cgCommand : CairngormEvent):void
		{
			var command : LeaveCommand = LeaveCommand(cgCommand);
			
			model.conferenceDelegate.leave();
		}		
	}
}