package org.blindsideproject.core.apps.voiceconference.controller.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.voiceconference.controller.VoiceConferenceController;

	public class MuteUnmuteUserEvent extends CairngormEvent
	{
		public var userId : Number;
		public var muteUser : Boolean;
		
		public function MuteUnmuteUserEvent(userId : Number, muteUser : Boolean) : void
		{
			super(VoiceConferenceController.MUTE_UNMUTE_USER_COMMAND);
			this.userId = userId;
			this.muteUser = muteUser;	
		}
	}
}