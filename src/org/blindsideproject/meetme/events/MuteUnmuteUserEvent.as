package org.blindsideproject.meetme.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.meetme.control.MeetMeController;
	
	public class MuteUnmuteUserEvent extends CairngormEvent
	{
		private var userId : Number;
		private var muteUser : Boolean;
		
		public function MuteUnmuteUserEvent(userId : Number, muteUser : Boolean) : void
		{
			super(MeetMeController.MUTE_UNMUTE_USER_COMMAND);
			this.userId = userId;
			this.muteUser = muteUser;	
		}
		
		public function getUserId() : Number
		{
			return userId;
		}
		
		public function getMuteUser() : Boolean
		{
			return muteUser;
		}
	}
}