package org.blindsideproject.WhiteBoard.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.WhiteBoard.control.DrawController;
	
	public class ClearEvent extends CairngormEvent
	{
		public function ClearEvent(){
			super(DrawController.EVENT_CLEAR);
		}
	}
}