package org.bigbluebutton.modules.voiceconference.control
{
	import org.bigbluebutton.modules.voiceconference.VoiceConferenceFacade;
	import org.bigbluebutton.modules.voiceconference.model.business.NetConnectionDelegate;
	import org.bigbluebutton.modules.voiceconference.model.business.VoiceConfConnectResponder;
	import org.bigbluebutton.modules.voiceconference.view.ListenersWindow;
	import org.bigbluebutton.modules.voiceconference.view.ListenersWindowMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**
	 * This command gets called from the facade when the application is first started 
	 * @author dzgonjan
	 * 
	 */	
	public class StartupVoiceConfCommand extends SimpleCommand
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
			facade.registerMediator(new ListenersWindowMediator(app));
			facade.registerProxy(new NetConnectionDelegate(VoiceConferenceFacade.getInstance().meetMeRoom));
			facade.registerProxy(new VoiceConfConnectResponder(VoiceConferenceFacade.getInstance().meetMeRoom));
		}
	}
}