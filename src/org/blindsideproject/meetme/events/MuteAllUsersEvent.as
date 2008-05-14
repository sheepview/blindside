package org.blindsideproject.meetme.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.meetme.control.MeetMeController;
	
	public class MuteAllUsersEvent extends CairngormEvent
	{
		public var muteUsers : Boolean;
		
		public function MuteAllUsersEvent(muteUsers : Boolean) : void
		{
			super(MeetMeController.MUTE_ALL_USERS_COMMAND);
			this.muteUsers = muteUsers;	
		}
	}
}