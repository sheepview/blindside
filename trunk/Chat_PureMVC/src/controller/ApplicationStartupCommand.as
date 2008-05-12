package chat.controller
{
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
    import chat.model.MessageProxy;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import chat.view.ApplicationMediator;
	import chat.view.Chat;
	import chat.model.*;
	
	/**
	 * 
	 * @author snegari
	 * 
	 */	
	public class ApplicationStartupCommand extends SimpleCommand
	{
		/**
		 * 
		 * @param notification
		 * 
		 */	    
		override public function execute(notification:INotification):void {
			var app:BlindsideMVC = notification.getBody() as BlindsideMVC;
			facade.registerMediator(new ApplicationMediator(app));
			facade.registerProxy(new MessageProxy(app.chat.messageVO));
		}
		
		
	}
}