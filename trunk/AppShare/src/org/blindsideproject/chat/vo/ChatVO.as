package org.blindsideproject.chat.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
	public class ChatVO implements IValueObject
	{
		public var message:String = "";
		public var name:String;
	}
}