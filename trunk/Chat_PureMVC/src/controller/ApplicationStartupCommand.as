package controller
{
	import org.puremvc.as3.patterns.command.SimpleCommand;
    import model.MessageProxy;
	import org.puremvc.as3.interfaces.INotification;
	import view.ApplicationMediator;
	import view.Chat;
	import model.*;
	
	
	public class ApplicationStartupCommand extends SimpleCommand
	{
		//public static const EXECUTED:String = "StartupCommand executed";
		//private var test:String;
		
		override public function execute(notification:INotification):void{
			
			var app:Chat_PureMVC = notification.getBody() as Chat_PureMVC;
			//this.test = ApplicationStartupCommand.EXECUTED;
			facade.registerMediator(new ApplicationMediator(app));
			facade.registerProxy(new MessageProxy(app.chat.messageVO));
		}
		
		/**
		 * A test method to see if the command is executed. Used in Unit Tests 
		 * @return 
		 * 
		 */		
		//public function checkExecute():String{
		//	return this.test;
		//}
		
	}
}