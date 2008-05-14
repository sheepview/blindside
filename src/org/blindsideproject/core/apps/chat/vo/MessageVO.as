package org.blindsideproject.core.apps.chat.vo
{

	[Bindable]
	public class MessageVO
	{
		public var message : String = "";
		
	
		public function MessageVO(message:String):void
		{
			this.message = message;
		}
		
	}
	
}