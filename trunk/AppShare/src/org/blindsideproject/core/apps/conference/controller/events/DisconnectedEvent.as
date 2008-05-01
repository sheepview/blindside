package org.blindsideproject.core.apps.conference.controller.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class DisconnectedEvent extends CairngormEvent
	{		
		private var reason : uint = UNKNOWN_REASON;
		private var message : String;
		
		public function DisconnectedEvent(type : String, msg : String = "") : void
		{
			super(type);
			this.message = msg;
		}
		
		public function getReason():uint
		{
			return reason;
		}
		
		public function getMessage():String
		{
			return message;
		}
		
		public static const UNKNOWN_REASON : uint = 0;
		public static const FAILED : uint = 1;
		public static const CLOSED : uint = 2;
		public static const INVALID_APP : uint = 3;
		public static const APP_SHUTDOWN : uint = 4;
		public static const REJECTED : uint = 5;
	}
}