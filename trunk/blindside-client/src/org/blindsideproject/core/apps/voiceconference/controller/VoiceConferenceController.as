package org.blindsideproject.core.apps.voiceconference.controller
{
	import com.adobe.cairngorm.control.FrontController;
	import org.blindsideproject.core.apps.voiceconference.controller.handlers.*;
	
	public class VoiceConferenceController extends FrontController
	{
		public static const ID : String = "VoiceConferenceController";
		
		public function VoiceConferenceController()
		{
			addCommand(VoiceConferenceController.JOIN_COMMAND, JoinCommandHandler);
			addCommand(VoiceConferenceController.LEAVE_COMMAND, LeaveCommandHandler);
			addCommand(VoiceConferenceController.EJECT_USER_COMMAND, EjectUserCommandHandler);
			addCommand(VoiceConferenceController.MUTE_USER_COMMAND, MuteUserCommandHandler);	
			addCommand(VoiceConferenceController.MUTE_ALL_USERS_COMMAND, MuteAllUsersCommandHandler);		
		}
		
		public static const JOIN_COMMAND : String = "VOICE_CONFERENCE_JOIN_COMMAND";
		public static const LEAVE_COMMAND : String = "VOICE_CONFERENCE_LEAVE_COMMAND";
		public static const EJECT_USER_COMMAND : String = "VOICE_CONFERENCE_EJECT_USER_COMMAND";
		public static const MUTE_USER_COMMAND : String = "VOICE_CONFERENCE_MUTE_USER_COMMAND";	
		public static const MUTE_ALL_USERS_COMMAND : String = "VOICE_CONFERENCE_MUTE_ALL_USERS_COMMAND";	
	}
}