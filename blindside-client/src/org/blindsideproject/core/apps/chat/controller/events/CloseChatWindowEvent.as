package org.blindsideproject.core.apps.chat.controller.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class CloseChatWindowEvent extends CairngormEvent
	{
		public var fromUserid : Number;
		public var toUserid : Number;
		public var fromUsername : String;
		public var toUsername : String;
		
		public function CloseChatWindowEvent(type:String , fromUserid:Number ,
		 toUserid:Number , fromUsername:String , toUsername:String ):void
		{
			super(type);
			this.fromUserid = fromUserid;
			this.toUserid = toUserid;
			this.fromUsername = fromUsername;
			this.toUsername = toUsername;
		}
		
	}
}