package org.blindsideproject.WhiteBoard.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.WhiteBoard.control.DrawController;
	
	public class UpdateEvent extends CairngormEvent
	{
		public function UpdateEvent(){
			super(DrawController.EVENT_UPDATE);
		}
	}
}