package org.blindsideproject.conference.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.blindsideproject.conference.command.*;
	
	public class ConferenceController extends FrontController
	{
		public function ConferenceController()
		{
			addCommand(ConferenceController.JOIN_COMMAND, ConferenceJoinCommand);
			addCommand(ConferenceController.LEAVE_COMMAND, ConferenceLeaveCommand);
			addCommand(ConferenceController.EJECT_USER_COMMAND, ConferenceKickCommand);
			addCommand(ConferenceController.CHANGE_STATUS_COMMAND, ConferenceChangeStatusCommand);
		}
		
		public static const JOIN_COMMAND : String = "CONFERENCE_JOIN";
		public static const LEAVE_COMMAND : String = "CONFERENCE_LEAVE";
		public static const EJECT_USER_COMMAND : String = "CONFERENCE_EJECT_USER";
		public static const CHANGE_STATUS_COMMAND : String = "CONFERENCE_CHANGE_STATUS";

	}
}