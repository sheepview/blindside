package controller
{
	import model.DrawProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.ApplicationMediator;
	
	public class StartupCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			//facade.registerProxy(new DrawProxy());
			
			var app:whiteboard = notification.getBody() as whiteboard;
			app.txtDebug.text += "\n SimpleCommand.execute";
			facade.registerMediator(new ApplicationMediator(app));
			facade.registerProxy(new DrawProxy(app.board.drawVO));
		}

	}
}