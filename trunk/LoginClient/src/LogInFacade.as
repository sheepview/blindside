package
{
	import controller.StartupCommand;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	/**
	 * The LogInFacade is a singleton class that provides a simple interface to access other important
	 * parts of this application 
	 * @author dzgonjan
	 * 
	 */	
	public class LogInFacade extends Facade implements IFacade
	{
		public static const NAME:String = "LogInFacade";
		public static const STARTUP:String = "startup";
		public static const LOGIN_ATTEMPT:String = "loginAttempt";
		public static const CALL_FAILED:String = "remoteCallFailed";
		public static const REGISTER_ATTEMPT:String = "registerAttempt";
		public static const NOT_CONNECTED:String = "not connected";
		
		public function LogInFacade(){
			super(NAME);
		}
		
		/**
		 * Returns the BoardFacade instance. This method always returns the same instance of this class
		 * @return the instance of BoardFacade
		 * 
		 */		
		public static function getInstance():LogInFacade{
			if ( instanceMap[NAME] == null) instanceMap[NAME] = new LogInFacade();
			return instanceMap[NAME] as LogInFacade;
		}
		
		/**
		 * Initializes the controller part of the application through the PureMVC framework.
		 * This functionality is abstracted inside of PureMVC
		 * <p>
		 * The BoardFacade listens to the STARTUP event. Once a STARTUP event is generated, the BoardFacade
		 * creates a new StartupCommand object to initialize the rest of the application.
		 * 
		 */		
		override protected function initializeController():void{
			super.initializeController();
			registerCommand(STARTUP, StartupCommand);  
		}
		
		/**
		 * The startup method is called from the Whiteboard.mxml component upon creationComplete().
		 * This method sends out a STARTUP notification.
		 * @param app
		 * 
		 */		
		public function startup(app:LoginClient):void{
			sendNotification(LogInFacade.STARTUP, app);
		}

	}
}