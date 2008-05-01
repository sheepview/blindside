package org.blindsideproject.WhiteBoard.control
{
	import com.adobe.cairngorm.control.FrontController;
	import org.blindsideproject.WhiteBoard.command.*;
	
	public class DrawController extends FrontController
	{
		public static const EVENT_SEND_SHAPE : String = "EVENT_SEND_SHAPE";
		public static const EVENT_UPDATE:String = "EVENT_UPDATE";
		public static const EVENT_CHANGE_COLOR:String = "EVENT_CHANGE_COLOR";
		public static const EVENT_CLEAR:String = "EVENT_CLEAR";
		public static const EVENT_SEND_CLEAR:String = "EVENT_SEND_CLEAR";
		
		public function DrawController():void{
			addCommand(DrawController.EVENT_SEND_SHAPE, SendShapeCommand);
			addCommand(DrawController.EVENT_CHANGE_COLOR, SendColorCommand);
			addCommand(DrawController.EVENT_SEND_CLEAR, SendClearCommand);
		}
	}
}