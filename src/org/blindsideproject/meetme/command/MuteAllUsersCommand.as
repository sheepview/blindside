package org.blindsideproject.meetme.command
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	import org.blindsideproject.meetme.model.MeetMeModelLocator;
	import org.blindsideproject.meetme.model.MeetMeRoom;
	import org.blindsideproject.meetme.events.MuteAllUsersEvent;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
	
	public class MuteAllUsersCommand implements ICommand
	{
		private var model : MeetMeModelLocator = MeetMeModelLocator.getInstance();
		private var meetMeRoom : MeetMeRoom = model.meetMeRoom;
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		
		public function execute(cgEvent:CairngormEvent):void
		{
			var event : MuteAllUsersEvent = MuteAllUsersEvent(cgEvent);	
			
			log.debug("MuteAllUsersCommand::execute : [" + event.muteUsers + "]");
			
			meetMeRoom.getConnection().muteAllUsers(event.muteUsers);
		}
		
	}
}