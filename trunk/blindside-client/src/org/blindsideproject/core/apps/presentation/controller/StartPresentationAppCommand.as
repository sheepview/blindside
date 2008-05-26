package org.blindsideproject.core.apps.presentation.controller
{
	import org.blindsideproject.core.apps.presentation.PresentationApplication;
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