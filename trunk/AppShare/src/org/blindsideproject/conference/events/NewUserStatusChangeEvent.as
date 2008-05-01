package org.blindsideproject.conference.events
{
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class NewUserStatusChangeEvent extends CairngormEvent
	{
		private var userid : Number;
		private var newStatus : String;
		
		public function NewUserStatusChangeEvent(type : String,
				userid : Number, newStatus : String) : void
		{
			super(type)
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