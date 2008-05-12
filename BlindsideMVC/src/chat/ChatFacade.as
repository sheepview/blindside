package chat
{
	
	import chat.controller.ApplicationStartupCommand;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;

	
	/**
	 * 
	 * @author snegari
	 * 
	 */
	public class ChatFacade extends Facade implements IFacade
	{
		
		public static const NAME:String = "ChatFacade";
		public static const STARTUP:String           = "startup";
		public static const UPDATE:String            = "update";
		public static const SEND_MESSAGE:String      = "sendMessage";
		
		
		public function ChatFacade(){
			super(NAME);
		}
		/**
		 * 
		 * @returns the instance of ApplicationFacade
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
			registerCommand(STARTUP, ApplicationStartupCommand);
			
		}
		
		/**
		 * 
		 * @param app
		 * 
		 */
		public function startup(app:BlindsideMVC):void {
			
			sendNotification(ChatFacade.STARTUP, app);
		}
		
	}
}