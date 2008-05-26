package org.blindsideproject.core.apps.presentation.controller
{
	import org.blindsideproject.core.apps.presentation.business.PresentationDelegate;
	import org.blindsideproject.views.presentation.PresentationWindow;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class StartupModelCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			var app:PresentationWindow = notification.getBody() as PresentationWindow;
			facade.registerProxy(new PresentationDelegate());
		}

	}
}