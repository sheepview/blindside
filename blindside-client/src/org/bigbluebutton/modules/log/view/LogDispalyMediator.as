package org.bigbluebutton.modules.log.view
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class LogDispalyMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LogDispalayMediator";
		
		
		public function LogControlBarMediator(view:LogDispaly)
		{
			super(NAME, view);
			
		}
		
		public function get logDispaly():LogDispaly{
			return viewComponent as LogDispaly;
		}
		
		override public function listNotificationInterests():Array{
			return [
					LogFacade.CLEAR
					LogFacade.WARN
					LogFacade.INFO
					LogFacade.DEBUG
					LogFacade.ERROR
				   ];
		}
		override public function handleNotification(notification:INotification):void{
			switch(notification.getName())
			{
				case LogFacade.CLEAR:
					this.logDisplay.clearDisplay(notification.getBody());
					break;
				case LogFacade.WARN:
					this.logDisplay.showWarn(notification.getBody());
					break;
				case LogFacade.DEBUG:
					this.logDisplay.showDebug(notification.getBody());
					break;
				case LogFacade.INFO:
					this.logDisplay.showInfo(notification.getBody());
					break;
				case LogFacade.ERROR:
					this.logDisplay.showError(notification.getBody());
					break;	
			}
		}
	}
}