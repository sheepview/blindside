package
{
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	import controller.*;
	
	public class BoardFacade extends Facade implements IFacade
	{
		public static const STARTUP:String = "startup";
		
		public static function getInstance():BoardFacade{
			if (instance == null) instance = new BoardFacade();
			return instance as BoardFacade;
		}
		
		public function startup(app:whiteboard):void{
			app.txtDebug.text += "\n startup"
			sendNotification(BoardFacade.STARTUP, app);
		}
		
		override protected function initializeController():void{
			super.initializeController();
			registerCommand(STARTUP, StartupCommand);
		}

	}
}