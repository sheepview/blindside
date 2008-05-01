package org.blindsideproject.core.apps.conference.controller
{
	import com.adobe.cairngorm.control.FrontController;
	import org.blindsideproject.core.apps.conference.controller.handlers.*;
	
	public class ConferenceController extends FrontController
	{
		public static const ID : String = "org.blindsideproject.core.apps.conference.contoller.ConferenceController";
		
		public function ConferenceController()
		{
			addCommand(ConferenceController.JOIN_COMMAND, JoinCommandHandler);
			addCommand(ConferenceController.LEAVE_COMMAND, LeaveCommandHandler);
			addCommand(ConferenceController.EJECT_USER_COMMAND, EjectUserCommandHandler);
			addCommand(ConferenceController.CHANGE_STATUS_COMMAND, ChangeStatusCommandHandler);			
		}
		
		public static const JOIN_COMMAND : String = "CONFERENCE_JOIN_COMMAND";
		public static const LEAVE_COMMAND : String = "CONFERENCE_LEAVE_COMMAND";
		public static const EJECT_USER_COMMAND : String = "CONFERENCE_EJECT_USER_COMMAND";
		public static const CHANGE_STATUS_COMMAND : String = "CONFERENCE_CHANGE_STATUS_COMMAND";		
	}
}