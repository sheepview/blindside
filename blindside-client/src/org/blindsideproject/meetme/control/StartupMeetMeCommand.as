package org.blindsideproject.meetme.control
{
	import org.blindsideproject.meetme.business.MeetMeConnectResponder;
	import org.blindsideproject.meetme.business.NetConnectionDelegate;
	import org.blindsideproject.meetme.model.MeetMeFacade;
	import org.blindsideproject.meetme.view.ListenersWindow;
	import org.blindsideproject.meetme.view.ListenersWindowMediator;
	import org.blindsideproject.meetme.view.MeetMeUserItemMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class StartupMeetMeCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			var app:ListenersWindow = notification.getBody() as ListenersWindow;
			facade.registerMediator(new ListenersWindowMediator(app));
			//facade.registerMediator(new MeetMeUserItemMediator(app.participantsList));
			facade.registerProxy(new NetConnectionDelegate(MeetMeFacade.getInstance().meetMeRoom));
			facade.registerProxy(new MeetMeConnectResponder(MeetMeFacade.getInstance().meetMeRoom));
		}
	}
}