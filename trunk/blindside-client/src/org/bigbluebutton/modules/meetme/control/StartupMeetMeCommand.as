package org.bigbluebutton.modules.meetme.control
{
	import org.bigbluebutton.modules.meetme.MeetMeFacade;
	import org.bigbluebutton.modules.meetme.model.business.MeetMeConnectResponder;
	import org.bigbluebutton.modules.meetme.model.business.NetConnectionDelegate;
	import org.bigbluebutton.modules.meetme.view.ListenersWindow;
	import org.bigbluebutton.modules.meetme.view.ListenersWindowMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class StartupMeetMeCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			var app:ListenersWindow = notification.getBody() as ListenersWindow;
			facade.registerMediator(new ListenersWindowMediator(app)); NetConnectionDelegate
			//facade.registerMediator(new MeetMeUserItemMediator(app.participantsList));
			facade.registerProxy(new NetConnectionDelegate(MeetMeFacade.getInstance().meetMeRoom));
			facade.registerProxy(new MeetMeConnectResponder(MeetMeFacade.getInstance().meetMeRoom));
		}
	}
}