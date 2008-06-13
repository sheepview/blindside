package org.bigbluebutton.modules.viewers
{
	import mx.modules.ModuleBase;
	
	import org.bigbluebutton.common.IRouterAware;
	import org.bigbluebutton.common.Router;
	import org.bigbluebutton.main.view.components.MainApplicationShell;
	
	public class ViewersModule extends ModuleBase implements IRouterAware
	{
		public static const NAME:String = "VoiceModule";
		
		private var facade:ViewersFacade;
		private var _router:Router;
		private var mshell:MainApplicationShell;
		
		public function ViewersModule()
		{
			super();
			facade = ViewersFacade.getInstance();
		}
		
		public function acceptRouter(router:Router, shell:MainApplicationShell):void{
			mshell = shell;
			_router = router;
			facade.startup(this);
		}

		public function get router():Router{
			return _router;
		}
	}
}