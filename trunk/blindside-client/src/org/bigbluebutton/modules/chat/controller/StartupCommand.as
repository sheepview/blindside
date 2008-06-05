package org.bigbluebutton.modules.chat.controller
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.bigbluebutton.modules.chat.view.ApplicationMediator;
	import org.bigbluebutton.modules.chat.view.components.ChatWindow;
	import org.bigbluebutton.modules.chat.model.business.ChatProxy;
	import org.bigbluebutton.main.view.components.MainApplicationShell;

	public class StartupCommand extends SimpleCommand implements ICommand
	{
		
		/**
		 * registers the mediator and proxy with the facade
		 * @param notification
		 * 
		 */		
		override public function execute(notification:INotification):void {
			var app:MainApplicationShell = notification.getBody() as MainApplicationShell;
			facade.registerMediator(new ApplicationMediator(app));
			facade.registerProxy(new ChatProxy(app.chatWindow.messageVO));
		}
	}
}