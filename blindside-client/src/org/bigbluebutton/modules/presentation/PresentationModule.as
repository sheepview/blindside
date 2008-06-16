package org.bigbluebutton.modules.presentation
{
	import mx.modules.ModuleBase;
	
	import org.bigbluebutton.common.Constants;
	import org.bigbluebutton.common.IRouterAware;
	import org.bigbluebutton.common.Router;
	import org.bigbluebutton.main.view.components.MainApplicationShell;
	import org.bigbluebutton.modules.viewers.ViewersFacade;
	import org.bigbluebutton.modules.viewers.model.business.Conference;
	
	public class PresentationModule extends ModuleBase implements IRouterAware
	{
		public static const NAME:String = "Presentation Module";
		
		public static const DEFAULT_RED5_URL:String = "rtmp://" + Constants.RED5_HOST;
		public static const DEFAULT_PRES_URL:String = "http://" + Constants.PRESENTATION_HOST;
		
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
			var conf:Conference = ViewersFacade.getInstance().retrieveMediator(Conference.NAME) as Conference;
			facade.setPresentationApp(conf.me.userid, conf.room, DEFAULT_RED5_URL, DEFAULT_PRES_URL);
			facade.presApp.join();
		}
		
		public function get router():Router{
			return _router;
		}

	}
}