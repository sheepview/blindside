package org.blindsideproject.WhiteBoard.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.WhiteBoard.control.DrawController;
	
	public class SendClearEvent extends CairngormEvent
	{
		public var clear:Boolean;
		
		public function SendClearEvent(clear:Boolean){
			super(DrawController.EVENT_SEND_CLEAR);
			this.clear = clear;
		}
	}
}