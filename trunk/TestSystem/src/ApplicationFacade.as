package
{
	import org.puremvc.as3.patterns.facade.Facade;
	import org.puremvc.as3.interfaces.IFacade;
	import controller.ApplicationStartupCommand;

	public class ApplicationFacade extends Facade implements IFacade
	{
		
		public static const STARTUP:String           = "startup";
		public static const UPDATE:String            = "update";
		
		
		public static function getInstance():ApplicationFacade{
			if (instance == null) instance = new ApplicationFacade();
			return instance as ApplicationFacade;
		}
		
		override protected function initializeController():void{
			super.initializeController();
			registerCommand(STARTUP, ApplicationStartupCommand);
			
		}
		
		public function startup(app:TestSystem):void{
			
			sendNotification(STARTUP, app);
		}
	}
}