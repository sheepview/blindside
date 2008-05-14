package org.blindsideproject.core.apps.voiceconference.controller.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.voiceconference.controller.VoiceConferenceController;

	public class MuteAllUsersEvent extends CairngormEvent
	{
		public var muteUsers : Boolean;
		
		public function MuteAllUsersEvent(muteUsers : Boolean) : void
		{
			super(VoiceConferenceController.MUTE_ALL_USERS_COMMAND);
			this.muteUsers = muteUsers;	
		}
	}
}