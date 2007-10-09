package org.blindsideproject.core.apps.chat.controller.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class NewChatMessageEvent extends CairngormEvent
	{
		public var userid : Number;
		public function NewChatMessageEvent(type:String , userid:Number):void
		{
			super(type);
			this.userid = userid;
		}
		
	}
}