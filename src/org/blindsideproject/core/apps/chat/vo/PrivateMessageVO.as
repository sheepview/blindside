package org.blindsideproject.core.apps.chat.vo
{
	
	[Bindable]
	public class PrivateMessageVO
	{
		public var privateMessage : String = "";
		public var userid : Number;
		public var toUserid : Number;
		public var index : int;

		
		public function PrivateMessageVO(privateMessage:String):void
		{
			this.privateMessage = privateMessage;
		}
	}
}