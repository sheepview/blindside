package controller
{
	import org.puremvc.as3.patterns.command.SimpleCommand;
    import model.TestProxy;
	import org.puremvc.as3.interfaces.INotification;
	import view.ApplicationMediator;
	import view.Test;
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
			
			var app:TestSystem = notification.getBody() as TestSystem;
			facade.registerMediator(new ApplicationMediator(app));
			facade.registerProxy(new TestProxy(app.test.conference));
		}
		
		
	}
}