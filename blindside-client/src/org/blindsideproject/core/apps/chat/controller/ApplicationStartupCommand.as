package org.blindsideproject.core.apps.chat.model
{
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
    import org.blindsideproject.core.apps.chat.model.MessageProxy;
    import org.blindsideproject.core.apps.chat.model.MEssageObject;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.blindsideproject.views.chat.ApplicationMediator;
	import org.blindsideproject.views.chat.PublicChat;
	
	
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
			var app:main = notification.getBody() as main;
			facade.registerMediator(new ApplicationMediator(app));
			facade.registerProxy(new MessageProxy(app.chat.messageVO));
		}
		
		
	}
}