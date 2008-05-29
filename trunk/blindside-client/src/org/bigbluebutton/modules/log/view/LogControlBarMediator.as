package org.bigbluebutton.modules.log.view
{
	import org.bigbluebutton.modules.log.model.LogProxy;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class LogControlBarMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LogControlBarMediator";
		public static const CLEAR_LOG:String = "ClearLog";
		
		
		
		public function LogControlBarMediator(view:LogControlBar)
		{
			super(NAME, view);
			LogControlBar.addEventListener(CLEAR_LOG,onClearLog);
		}
		
		public function get logControlBar():LogControlBar{
			return viewComponent as LogControlBar;
		}
		public function onClearLog():void {
			proxy.sendClearLog();
		}
		
				
		public function get proxy():LogProxy {
			return facade.retrieveProxy() as LogProxy;
		}
	}
}