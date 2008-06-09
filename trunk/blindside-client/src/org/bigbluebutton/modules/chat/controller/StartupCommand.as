package org.bigbluebutton.modules.chat.controller
{
	import org.bigbluebutton.modules.chat.ChatModule;
	import org.bigbluebutton.modules.chat.model.business.ChatProxy;
	import org.bigbluebutton.modules.chat.view.ChatModuleMediator;
	import org.bigbluebutton.modules.chat.view.ChatWindowMediator;
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
			var app:ChatModule = notification.getBody() as ChatModule;
			
			facade.registerMediator(new ChatModuleMediator(app));
			facade.registerMediator( new ChatWindowMediator(app.chatWindow) );
			facade.registerProxy(new ChatProxy(app.chatWindow.messageVO));
		}
	}
}