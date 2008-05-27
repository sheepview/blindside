package org.bigbluebutton.modules.chat.controller
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.interfaces.INotification;

	public class StartupCommand extends SimpleCommand implements ICommand
	{
		public function StartupCommand()
		{
			super();
		}
		
		public function execute(notification:INotification):void
		{
		}
		
		public function sendNotification(notificationName:String, body:Object=null, type:String=null):void
		{
		}
		
		public function initializeNotifier(key:String):void
		{
		}
		/**
		 * registers the mediator and proxy with the facade
		 * @param notification
		 * 
		 */		
		override public function execute(notification:INotification):void {
			var app:BigBlueButton = notification.getBody() as BigBlueButton;
			facade.registerMediator(new ApplicationMediator(app));
			facade.registerProxy(new ChatProxy(app.chatWindow.messageVO));
		}
	}
}