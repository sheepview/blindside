package org.bigbluebutton.modules.voiceconference.control
{
	import org.bigbluebutton.modules.voiceconference.VoiceConferenceFacade;
	import org.bigbluebutton.modules.voiceconference.VoiceModule;
	import org.bigbluebutton.modules.voiceconference.VoiceModuleMediator;
	import org.bigbluebutton.modules.voiceconference.model.business.NetConnectionDelegate;
	import org.bigbluebutton.modules.voiceconference.model.business.VoiceConfConnectResponder;
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
			var app:VoiceModule = notification.getBody() as VoiceModule;
			facade.registerMediator(new VoiceModuleMediator(app));
			
			facade.registerProxy(new NetConnectionDelegate(VoiceConferenceFacade.getInstance().meetMeRoom.getUri()));
			facade.registerMediator(new VoiceConfConnectResponder(VoiceConferenceFacade.getInstance().meetMeRoom));
		}
	}
}