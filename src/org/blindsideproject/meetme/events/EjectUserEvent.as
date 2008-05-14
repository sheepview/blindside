package org.blindsideproject.meetme.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.meetme.control.MeetMeController;
	
	public class EjectUserEvent extends CairngormEvent
	{
		private var userId : Number;
		
		public function EjectUserEvent(userId : Number) 
		{
			super(MeetMeController.EJECT_USER_COMMAND);
			this.userId = userId;
		}
			
		public function getUserId() : Number
		{
			return userId;
		}		
	}
}