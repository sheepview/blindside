package controller
{
	import org.puremvc.as3.patterns.command.SimpleCommand;
    import model.MessageProxy;
	import org.puremvc.as3.interfaces.INotification;
	import view.ApplicationMediator;
	import view.Chat;
	import model.*;
	
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
		override public function execute(notification:INotification):void{
			
			var app:Chat_PureMVC = notification.getBody() as Chat_PureMVC;
			facade.registerMediator(new ApplicationMediator(app));
			facade.registerProxy(new MessageProxy(app.chat.messageVO));
		}
		
		
	}
}