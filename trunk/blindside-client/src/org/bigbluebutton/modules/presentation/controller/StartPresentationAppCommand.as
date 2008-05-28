package org.bigbluebutton.modules.presentation.controller
{
	import org.bigbluebutton.modules.presentation.PresentationApplication;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class StartPresentationAppCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			var presApp:PresentationApplication = notification.getBody() as PresentationApplication;
			facade.registerMediator(presApp);
		}

	}
}