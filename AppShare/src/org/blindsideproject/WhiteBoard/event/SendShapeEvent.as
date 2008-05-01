package org.blindsideproject.WhiteBoard.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.WhiteBoard.control.DrawController;
	import flash.display.Shape;
	
	public class SendShapeEvent extends CairngormEvent
	{
		public var shape:Array;
		
		public function SendShapeEvent(shape:Array){
			super(DrawController.EVENT_SEND_SHAPE);
			this.shape = shape;
		}
	}
}