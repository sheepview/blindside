package org.bigbluebutton.modules.log
{
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;

	public class LogFacade extends Facade implements IFacade
	{
		
		public static const STARTUP:String        = "startup";
		public static const CLEAR:String          = "clear";
		public static const DEBUG:String	      = "debug";
		public static const WARN:String	          = "warn";
		public static const INFO:String	          = "info";
		public static const ERROR:String	      = "error";
		
		public function LogFacade(key:String)
		{
			super(key);
		}
		
		/**
		 * 
		 * @returns the instance of ChatFacade
		 * 
		 */
		public static function getInstance():LogFacade{
			if (instanceMap[NAME] == null) instanceMap[NAME] = new LogFacade();
			return instanceMap[NAME] as LogFacade;
		
		}
		
		/**
		 * initializes the controller and registers the required commands with it 
		 * 
		 */
		override protected function initializeController():void{
			super.initializeController();
			registerCommand(STARTUP, StartupCommand);
			
		}
		
		public function startup(app:LogWindow):void {
			
			sendNotification(LogFacade.STARTUP, app);
		}
		
		
	}
}