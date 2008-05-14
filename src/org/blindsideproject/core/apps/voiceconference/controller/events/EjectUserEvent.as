package org.blindsideproject.core.apps.voiceconference.controller.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class EjectUserEvent extends CairngormEvent
	{
		private var userId : Number;
		
		public function EjectUserEvent(userId : Number) 
		{
			super(VoiceConferenceController.EJECT_USER_COMMAND);
			this.userId = userId;
		}
			
		public function getUserId() : Number
		{
			return userId;
		}		
	}
}