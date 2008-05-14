package org.blindsideproject.core.apps.conference.controller.events
{
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class StatusChangeEvent extends CairngormEvent
	{
		private var userid : Number;
		private var newStatus : String;
		
		public function StatusChangeEvent(userid : Number, newStatus : String) : void
		{
			super(ConferenceEvents.STATUS_CHANGE_EVENT)
			this.userid = userid;
			this.newStatus = newStatus;	
		}
		
		public function getUserId() : Number
		{
			return userid;
		}
		
		public function getNewStatus() : String
		{
			return newStatus;
		}
	}
}