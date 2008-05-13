package
{
	
	import org.puremvc.as3.patterns.facade.Facade;
	import org.puremvc.as3.interfaces.IFacade;
	import controller.*;

	
	/**
	 * 
	 * @author snegari
	 * 
	 */
	public class ApplicationFacade extends Facade implements IFacade
	{
		
		public static const STARTUP:String           = "startup";
		public static const UPDATE:String            = "update";
		public static const SEND_MESSAGE:String      = "sendMessage";
		
		/**
		 * 
		 * @returns the instance of ApplicationFacade
		 * 
		 */
		public static function getInstance():ApplicationFacade{
			if (instance == null) instance = new ApplicationFacade();
			return instance as ApplicationFacade;
		}
		/**
		 * initializes the controller and registers the required commands with it 
		 * 
		 */
		override protected function initializeController():void{
			super.initializeController();
			registerCommand(STARTUP, ApplicationStartupCommand);
			
		}
		
		/**
		 * 
		 * @param app
		 * 
		 */
		public function startup(app:Chat_PureMVC):void{
			
			sendNotification(STARTUP, app);
		}
		
	}
}