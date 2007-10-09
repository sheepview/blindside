package org.blindsideproject.core.apps.chat.controller.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class NewChatRequestEvent extends CairngormEvent
	{
		public var fromUserid : Number;
		public var toUserid : Number;
		public var message : String;
		public var fromUsername : String;
		public var toUsername : String;
		public var initiator : Boolean;
		
		public function NewChatRequestEvent(type:String , fromUserid:Number , toUserid:Number ,
		 fromUsername:String , toUserName:String , message:String , initiator:Boolean = false):void
		{
			super(type);
			this.fromUserid = fromUserid;
			this.toUserid = toUserid;
			this.fromUsername = fromUsername;
			this.toUsername = toUsername;
			this.message = message;
			this.initiator = initiator;
			
			
			
		}
		
	}
}