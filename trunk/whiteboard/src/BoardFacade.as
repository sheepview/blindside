package
{
	import controller.*;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	
	/**
	 * The BoardFacade class is an implementation of the Facade pattern for the Whiteboard application.
	 * The Facade pattern delegates requests to the Model, View, Controller so that we don't have to interact
	 * with those classes directly
	 * <p>
	 * The BoardFacade class extends the Facade class of the PureMVC framework
	 * <p>
	 * The BoardFacade is also a Singleton - It cannot be instantiated more than once
	 * @author dzgonjan
	 * 
	 */	
	public class BoardFacade extends Facade implements IFacade
	{
		public static const STARTUP:String = "startup";
		public static const UPDATE:String = "update";
		
		/**
		 * Returns the BoardFacade instance. This method always returns the same instance of this class
		 * @return the instance of BoardFacade
		 * 
		 */		
		public static function getInstance():BoardFacade{
			if (instance == null) instance = new BoardFacade();
			return instance as BoardFacade;
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
		public function startup(app:whiteboard):void{
			app.txtDebug.text += "\n startup"
			sendNotification(BoardFacade.STARTUP, app);
		}

	}
}