package org.blindsideproject.core.apps.voiceconference.controller.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
	import org.blindsideproject.core.apps.voiceconference.controller.events.MuteAllUsersEvent;

	public class MuteAllUsersCommand implements ICommand
	{
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		
		public function execute(cgEvent:CairngormEvent):void
		{
			var event : MuteAllUsersEvent = MuteAllUsersEvent(cgEvent);	
		}
		
	}
}