package org.bigbluebutton.modules.presentation
{
	import mx.modules.ModuleBase;
	
	import org.bigbluebutton.common.IRouterAware;
	import org.bigbluebutton.common.Router;
	import org.bigbluebutton.main.view.components.MainApplicationShell;
	
	public class PresentationModule extends ModuleBase implements IRouterAware
	{
		public static const NAME:String = "Presentation Module";
		
		public static const DEFAULT_ID:Number = 1;
		public static const DEFUALT_ROOM:String = "85115";
		public static const DEFAULT_RED5_URL:String = "rtmp://present.carleton.ca" 
		public static const DEFAULT_PRES_URL:String = "http://present.carleton.ca";
		
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
			facade.setPresentationApp(DEFAULT_ID, DEFUALT_ROOM, DEFAULT_RED5_URL, DEFAULT_PRES_URL);
			facade.presApp.join();
		}
		
		public function get router():Router{
			return _router;
		}

	}
}