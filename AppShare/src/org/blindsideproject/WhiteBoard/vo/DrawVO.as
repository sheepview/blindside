package org.blindsideproject.WhiteBoard.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	import flash.display.Shape;
	
	[Bindable]
	public class DrawVO implements IValueObject
	{
		public var segment:Array = new Array();
		public var color:uint;
		public var clear:Boolean;
	}
}