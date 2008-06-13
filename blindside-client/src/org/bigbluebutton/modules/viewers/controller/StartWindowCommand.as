package org.bigbluebutton.modules.viewers.controller
{
	import org.bigbluebutton.modules.viewers.view.ViewersWindow;
	import org.bigbluebutton.modules.viewers.view.mediators.ViewersWindowMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class StartWindowCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			var window:ViewersWindow = notification.getBody() as ViewersWindow;
			
			facade.registerMediator(new ViewersWindowMediator(window));
		}

	}
}