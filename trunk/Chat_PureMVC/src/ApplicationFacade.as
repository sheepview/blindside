package
{
	
	import org.puremvc.as3.patterns.facade.Facade;
	import org.puremvc.as3.interfaces.IFacade;
	import controller.*;

	public class ApplicationFacade extends Facade implements IFacade
	{
		
		public static const STARTUP:String           = "startup";
		public static const UPDATE:String            = "update";
		public static const SEND_MESSAGE:String      = "sendMessage";
		
		public static function getInstance():ApplicationFacade{
			if (instance == null) instance = new ApplicationFacade();
			return instance as ApplicationFacade;
		}
		override protected function initializeController():void{
			super.initializeController();
			registerCommand(STARTUP, ApplicationStartupCommand);
			
		}
		//public function ApplicationFacade()
		//{
			//super();
		//}
		public function startup(app:Chat_PureMVC):void{
			
			sendNotification(STARTUP, app);
		}
		
	}
}