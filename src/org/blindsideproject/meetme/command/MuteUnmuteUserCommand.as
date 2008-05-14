package org.blindsideproject.meetme.command
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	import org.blindsideproject.meetme.model.MeetMeModelLocator;
	import org.blindsideproject.meetme.model.MeetMeRoom;
	import org.blindsideproject.meetme.events.MuteUnmuteUserEvent;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
	
	public class MuteUnmuteUserCommand implements ICommand
	{
		private var model : MeetMeModelLocator = MeetMeModelLocator.getInstance();
		private var meetMeRoom : MeetMeRoom = model.meetMeRoom;
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		
		public function execute(cgEvent:CairngormEvent):void
		{
			var event : MuteUnmuteUserEvent = MuteUnmuteUserEvent(cgEvent);	
			
			log.debug("MuteUnmuteUserCommand::execute : [" + event.getUserId() + "," + event.getMuteUser() + "]");
			
			meetMeRoom.getConnection().muteUnmuteUser(event.getUserId(),
					event.getMuteUser());
		}
		
	}
}