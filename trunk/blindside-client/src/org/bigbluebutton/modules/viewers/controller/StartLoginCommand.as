package org.bigbluebutton.modules.viewers.controller
{
	import org.bigbluebutton.modules.viewers.view.JoinWindow;
	import org.bigbluebutton.modules.viewers.view.mediators.JoinWindowMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class StartLoginCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			var window:JoinWindow = notification.getBody() as JoinWindow;
			facade.registerMediator(new JoinWindowMediator(window));
		}

	}
}