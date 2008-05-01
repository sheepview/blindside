package controller
{
	import model.DrawProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.ApplicationMediator;
	
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
			
			var app:whiteboard = notification.getBody() as whiteboard;
			app.txtDebug.text += "\n SimpleCommand.execute";
			facade.registerMediator(new ApplicationMediator(app));
			facade.registerProxy(new DrawProxy(app.board.drawVO));
		}

	}
}