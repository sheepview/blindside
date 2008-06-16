package org.bigbluebutton.modules.chat
{
	import org.bigbluebutton.modules.chat.controller.StartupCommand;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;

	/**
	 * 
	 * Class ChatFacade
	 * 
	 */	
	public class ChatFacade extends Facade implements IFacade
	{
		
		public static const NAME:String = "ChatFacade";
		public static const STARTUP:String          = "startup";
		public static const NEW_MESSAGE:String      = "newMessage";
		public static const CLOSE_CHAT:String       = "closeChat";
		
		
		public function ChatFacade()
		{
			super(NAME);
		}
		
		/**
		 * 
		 * @returns the instance of ChatFacade
		 * 
		 */
		public static function getInstance():ChatFacade{
			if (instanceMap[NAME] == null) instanceMap[NAME] = new ChatFacade();
			return instanceMap[NAME] as ChatFacade;
		
		}
		
		/**
		 * initializes the controller and registers the required commands with it 
		 * 
		 */
		override protected function initializeController():void{
			super.initializeController();
			registerCommand(STARTUP, StartupCommand);
			
		}
		/**
		 * 
		 * @param app:ChatModule
		 * 
		 */		
		public function startup(app:ChatModule):void {
			sendNotification(ChatFacade.STARTUP, app);
		}
		
		
		
	}
}