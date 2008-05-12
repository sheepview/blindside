package login.controller
{
	import login.model.LogInProxy;
	import login.view.ApplicationMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**
	 * The StartupCommand class extends the SimpleCommand class of the PureMVC framework.
	 * <p>
	 * Once the command is created, the execute method of the class is automaticaly called.
	 * The purpose of this class is to initialize the rest of the Whiteboard application, including the
	 * BoardMediator and the DrawProxy classes. 
	 * @author dzgonjan
	 * 
	 */	
	public class StartupCommand extends SimpleCommand
	{
		/**
		 * The execute method that is executed upon creation of this class 
		 * @param notification the notification which triggered the SimpleCommand class.
		 * 
		 */		
		override public function execute(notification:INotification):void{
			
			var app:BlindsideMVC = notification.getBody() as BlindsideMVC;
			facade.registerMediator(new ApplicationMediator(app));
			facade.registerProxy(new LogInProxy());
		}

	}
}