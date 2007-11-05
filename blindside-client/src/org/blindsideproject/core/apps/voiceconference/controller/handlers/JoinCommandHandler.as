package org.blindsideproject.core.apps.voiceconference.controller.handlers
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	
	import org.blindsideproject.core.util.log.ILogger;
	
	import mx.rpc.IResponder;
	import org.blindsideproject.core.apps.voiceconference.model.VoiceConferenceModelLocator;
	import org.blindsideproject.core.apps.voiceconference.controller.commands.JoinCommand;

	public class JoinCommandHandler implements ICommand
	{		
		private var model : VoiceConferenceModelLocator = VoiceConferenceModelLocator.getInstance();

		public function execute(cgCommand:CairngormEvent):void
		{
			var command : JoinCommand = JoinCommand(cgCommand);
		}
	}
}