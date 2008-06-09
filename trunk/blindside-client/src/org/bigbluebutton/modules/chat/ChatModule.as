package org.bigbluebutton.modules.chat
{
	import mx.modules.ModuleBase;
	
	import org.bigbluebutton.common.IRouterAware;
	import org.bigbluebutton.common.Router;
	import org.bigbluebutton.main.view.components.MainApplicationShell;
	import org.bigbluebutton.modules.chat.view.components.ChatWindow;

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
		
		
		/**
		 * costructor of class ChatModule 
		 * 
		 */		
		public function ChatModule()
		{
			super();
			chatWindow = new ChatWindow;
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
			shell.debugLog.text = 'In ChatModule';
			_router = router;
			shell.debugLog.text = 'In ChatModule 2';
			ChatFacade(facade).startup(this);			
			shell.debugLog.text = 'In ChatModule 3';
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