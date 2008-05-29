package org.bigbluebutton.modules.meetme.control
{
	import org.bigbluebutton.modules.meetme.MeetMeFacade;
	import org.bigbluebutton.modules.meetme.model.business.MeetMeConnectResponder;
	import org.bigbluebutton.modules.meetme.model.business.NetConnectionDelegate;
	import org.bigbluebutton.modules.meetme.view.ListenersWindow;
	import org.bigbluebutton.modules.meetme.view.ListenersWindowMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**
	 * This command gets called from the facade when the application is first started 
	 * @author dzgonjan
	 * 
	 */	
	public class StartupMeetMeCommand extends SimpleCommand
	{
		/**
		 * This method gets automatically called, there is no need to call it
		 * <p>
		 * This method initiates the mediators and the proxies that the application needs 
		 * @param notification
		 * 
		 */		
		override public function execute(notification:INotification):void{
			var app:ListenersWindow = notification.getBody() as ListenersWindow;
			facade.registerMediator(new ListenersWindowMediator(app)); NetConnectionDelegate
			facade.registerProxy(new NetConnectionDelegate(MeetMeFacade.getInstance().meetMeRoom));
			facade.registerProxy(new MeetMeConnectResponder(MeetMeFacade.getInstance().meetMeRoom));
		}
	}
}