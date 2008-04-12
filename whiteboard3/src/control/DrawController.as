package control
{
	import com.adobe.cairngorm.control.FrontController;
	
	import control.handler.*;
	
	/**
	 * The DrawController captures events dispatched by the CairngormEventDispatcher and triggers an appropriate
	 * command in response 
	 * @author Denis
	 * 
	 */	
	public class DrawController extends FrontController
	{
		public static const SEND_SHAPE_EVENT:String = "send_shape";
		public static const UPDATE_EVENT:String = "update";
		
		/**
		 *The Default constructor
		 * <p>
		 * If you wish to add a command to the Controller,place it into the constructor by using the addCommand method
		 * 
		 */		
		public function DrawController():void
		{
			addCommand(DrawController.SEND_SHAPE_EVENT, SendShapeCommandHandler);
		}

	}
}