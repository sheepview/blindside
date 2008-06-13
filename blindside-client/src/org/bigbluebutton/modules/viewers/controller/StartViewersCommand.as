package org.bigbluebutton.modules.viewers.controller
{
	import org.bigbluebutton.modules.viewers.ViewersModule;
	import org.bigbluebutton.modules.viewers.ViewersModuleMediator;
	import org.bigbluebutton.modules.viewers.model.business.Conference;
	import org.bigbluebutton.modules.viewers.model.services.SharedObjectConferenceDelegate;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class StartViewersCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			var app:ViewersModule = notification.getBody() as ViewersModule;
			
			facade.registerMediator(new ViewersModuleMediator(app));
			var conf:Conference = new Conference()
			facade.registerMediator(conf);
			facade.registerProxy(new SharedObjectConferenceDelegate(conf));
		}

	}
}