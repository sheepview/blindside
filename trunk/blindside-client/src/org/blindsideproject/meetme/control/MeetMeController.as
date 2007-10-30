package org.blindsideproject.meetme.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.blindsideproject.meetme.command.*;
	
	public class MeetMeController extends FrontController
	{
		public function MeetMeController()
		{
			addCommand(MeetMeController.MUTE_UNMUTE_USER_COMMAND, MuteUnmuteUserCommand);
			addCommand(MeetMeController.EJECT_USER_COMMAND, EjectUserCommand);
			addCommand(MeetMeController.MUTE_ALL_USERS_COMMAND, MuteAllUsersCommand);
		}
		
		public static const MUTE_UNMUTE_USER_COMMAND : String = "MEETME_MUTE_UNMUTE_USER";
		public static const EJECT_USER_COMMAND : String = "MEETME_EJECT_USER";
		public static const MUTE_ALL_USERS_COMMAND : String = "MEETME_MUTE_ALL_USER";
	}
}