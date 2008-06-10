package org.bigbluebutton.modules.presentation
{
	import mx.modules.ModuleBase;
	
	import org.bigbluebutton.common.IRouterAware;
	import org.bigbluebutton.common.Router;
	import org.bigbluebutton.main.view.components.MainApplicationShell;
	
	public class PresentationModule extends ModuleBase implements IRouterAware
	{
		public static const NAME:String = "Presentation Module";
		
		private var facade:PresentationFacade;
		private var _router:Router;
		public var mshell:MainApplicationShell;
		
		public function PresentationModule()
		{
			super();
			facade = PresentationFacade.getInstance();
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