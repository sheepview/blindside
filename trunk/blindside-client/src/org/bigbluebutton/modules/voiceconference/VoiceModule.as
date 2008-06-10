package org.bigbluebutton.modules.voiceconference
{
	import mx.modules.ModuleBase;
	
	import org.bigbluebutton.common.IRouterAware;
	import org.bigbluebutton.common.Router;
	import org.bigbluebutton.main.view.components.MainApplicationShell;
	
	public class VoiceModule extends ModuleBase implements IRouterAware
	{
		public static const NAME:String = "VoiceModule";
		public static const DEFAULT_URI:String = "rtmp://present.carleton.ca/astmeetme/85115"; 
		
		private var facade:VoiceConferenceFacade;
		private var _router:Router;
		private var mshell:MainApplicationShell;
		
		public function VoiceModule()
		{
			super();
			facade = VoiceConferenceFacade.getInstance();
		}
		
		public function acceptRouter(router:Router, shell:MainApplicationShell):void{
			mshell = shell;
			_router = router;
			facade.startup(this, DEFAULT_URI);
			facade.connectToMeetMe();
		}
		
		public function get router():Router{
			return _router;
		}

	}
}