package org.bigbluebutton.modules.viewers
{
	import org.bigbluebutton.modules.viewers.controller.StartLoginCommand;
	import org.bigbluebutton.modules.viewers.controller.StartViewersCommand;
	import org.bigbluebutton.modules.viewers.controller.StartWindowCommand;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	public class ViewersFacade extends Facade implements IFacade
	{
		public static const NAME:String = "ViewersFacade";
		
		public static const STARTUP:String = "Startup Command";
		public static const START_VIEWER_WINDOW:String = "Start Viewer Window";
		public static const CHANGE_STATUS:String = "Change Status Event";
		public static const START_LOGIN_WINDOW:String = "Start Login Window";
		public static const CONNECT_SUCCESS:String = "Connection Successful";
		
		public static const DEBUG:String = "Viewer Debug";
		
		public function ViewersFacade()
		{
			super(NAME);
		}
		
		public static function getInstance():ViewersFacade{
			if (instanceMap[NAME] == null) instanceMap[NAME] = new ViewersFacade;
			return instanceMap[NAME] as ViewersFacade;
		}
		
		override protected function initializeController():void{
			super.initializeController();
			registerCommand(STARTUP, StartViewersCommand);
			registerCommand(START_VIEWER_WINDOW, StartWindowCommand);
			registerCommand(START_LOGIN_WINDOW, StartLoginCommand);
		}
		
		public function startup(app:ViewersModule):void{
			sendNotification(STARTUP, app);
		}

	}
}