package org.bigbluebutton.modules.chat
{
	import mx.modules.ModuleBase;
	
	import org.bigbluebutton.common.IRouterAware;
	import org.bigbluebutton.common.Router;
	import org.bigbluebutton.main.view.components.MainApplicationShell;
	import org.bigbluebutton.modules.chat.view.components.ChatWindow;
	import org.bigbluebutton.modules.log.LogModuleFacade;

	/**
	 * 
	 * Class ChatModule acts as view component for Chat Application
	 * 
	 */	
	public class ChatModule extends ModuleBase implements IRouterAware
	{
		public static const NAME:String = 'ChatModule';
		public var mshell : MainApplicationShell;
		public var chatWindow : ChatWindow;
		private var facade : ChatFacade;		
		private var _router : Router;
		private var log : LogModuleFacade = LogModuleFacade.getInstance("LogModule");
		
		
		/**
		 * costructor of class ChatModule 
		 * 
		 */		
		public function ChatModule()
		{
			super();
			log.debug("Creating new ChatWindow...");
			chatWindow = new ChatWindow;
			log.debug("Getting an instance of Chat Facade...");
			facade = ChatFacade.getInstance();			
		}
		/**
		 * 
		 * @param router
		 * @param shell
		 * 
		 */		
		public function acceptRouter(router : Router, shell : MainApplicationShell) : void
		{
			mshell = shell;
			log.debug("Setting Router for Chat Module...");
			_router = router;
			ChatFacade(facade).startup(this);						
		}
		/**
		 * 
		 * @return router : Router
		 * 
		 */		
		public function get router() : Router
		{
			return _router;
		}
		
	}
}