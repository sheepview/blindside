package org.bigbluebutton.modules.chat.controller
{
	import org.bigbluebutton.modules.chat.model.business.ChatProxy;
	import org.bigbluebutton.modules.chat.view.ApplicationMediator;
	import org.bigbluebutton.modules.chat.view.ChatWindowMediator;
	import org.bigbluebutton.modules.chat.view.components.ChatWindow;
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class StartupCommand extends SimpleCommand implements ICommand
	{
		
		/**
		 * registers the mediator and proxy with the facade
		 * @param notification
		 * 
		 */		
		override public function execute(notification:INotification):void {
			var app:ChatWindow = notification.getBody() as ChatWindow;
			//facade.registerMediator(new ApplicationMediator(app));
			facade.registerMediator( new ChatWindowMediator( app ) );
			facade.registerProxy(new ChatProxy(app.messageVO));
		}
	}
}