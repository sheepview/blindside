package control
{
	import com.adobe.cairngorm.control.FrontController;
	
	import control.handler.SendShapeCommandHandler;
	
	public class DrawController extends FrontController
	{
		public static const SEND_SHAPE_EVENT:String = "send_shape";
		public static const UPDATE_EVENT:String = "update";
		
		public function DrawController():void
		{
			addCommand(DrawController.SEND_SHAPE_EVENT, SendShapeCommandHandler);
		}

	}
}