package org.bigbluebutton.modules.log.model
{
	import org.bigbluebutton.modules.log.model.vo.Logger;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class LogProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "LogProxy";
		
		public function LogProxy()
		{
			super(NAME, new Logger());
		}
		
		public function sendClearLog () {
			sendNotification(LogFacade.CLEAR);
		}
		
		
	}
}