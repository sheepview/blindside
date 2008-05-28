package org.bigbluebutton.modules.presentation.controller
{
	import org.bigbluebutton.modules.presentation.model.business.PresentationDelegate;
	import org.bigbluebutton.modules.presentation.view.PresentationWindow;
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