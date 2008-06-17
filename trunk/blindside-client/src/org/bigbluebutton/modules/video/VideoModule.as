package org.bigbluebutton.modules.video
{
	import mx.modules.ModuleBase;
	
	import org.bigbluebutton.common.IRouterAware;
	import org.bigbluebutton.common.Router;
	import org.bigbluebutton.main.view.components.MainApplicationShell;
	
	public class VideoModule extends ModuleBase implements IRouterAware
	{
		public static const NAME:String = "VideoModule";
		
		private var facade:VideoFacade;
		private var _router:Router;
		private var mshell:MainApplicationShell;
		
		public function VideoModule()
		{
			super();
			facade = VideoFacade.getInstance();
		}
		
		public function acceptRouter(router:Router, shell:MainApplicationShell):void{
			mshell = shell;
			this._router = router;
			facade.startup(this);
		}
		
		public function get router():Router{
			return this.router
		}

	}
}