package org.blindsideproject.WhiteBoard.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.WhiteBoard.control.DrawController;
	
	public class ChangeColorEvent extends CairngormEvent
	{
		public var color:uint;
		
		public function ChangeColorEvent(color:uint){
			super(DrawController.EVENT_CHANGE_COLOR);
			this.color = color;
		}
	}
}