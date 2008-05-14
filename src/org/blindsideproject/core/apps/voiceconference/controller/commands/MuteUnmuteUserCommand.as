package org.blindsideproject.core.apps.voiceconference.controller.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
	
	public class MuteUnmuteUserCommand implements ICommand
	{
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		
		public function execute(cgEvent:CairngormEvent):void
		{
			var event : MuteUnmuteUserEvent = MuteUnmuteUserEvent(cgEvent);	
		}
		
	}
}