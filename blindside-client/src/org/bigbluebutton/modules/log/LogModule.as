package org.bigbluebutton.modules.log
{
	import mx.modules.ModuleBase;
	
	import org.bigbluebutton.common.IRouterAware;
	import org.bigbluebutton.common.Router;
	import org.bigbluebutton.main.view.components.MainApplicationShell;
	
	/**
	 * 
	 * view component class for LogModuleMediator
	 * 
	 */	
	public class LogModule extends ModuleBase implements IRouterAware
	{
		public static const NAME:String = 'LogModule';
		
		private var facade : LogModuleFacade;		
		private var _router : Router;
		public var mshell : MainApplicationShell;
		/**
		 * Constructor 
		 * Gets an instance of facade
		 */		
		public function LogModule()
		{
			super();
			facade = LogModuleFacade.getInstance(NAME);			
		}
		/**
		 * setting up the router for the shell 
		 * @param router:Router
		 * @param shell:MAinApplicationShell
		 * 
		 */        
		public function acceptRouter(router : Router, shell : MainApplicationShell) : void
		{
			mshell = shell;
			shell.debugLog.text = 'In LogModule';
			_router = router;
			shell.debugLog.text = 'In LogModule 2';
			LogModuleFacade(facade).startup(this);			
			shell.debugLog.text = 'In LogModule 3';
		}
		/**
		 * 
		 * @return Router
		 * 
		 */		
		public function get router() : Router
		{
			return _router;
		}
	}
}