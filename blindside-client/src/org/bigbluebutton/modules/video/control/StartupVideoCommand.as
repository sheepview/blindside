package org.bigbluebutton.modules.video.control
{
	import org.bigbluebutton.modules.video.VideoModule;
	import org.bigbluebutton.modules.video.VideoModuleMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class StartupVideoCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			var app:VideoModule = notification.getBody() as VideoModule;
			
			facade.registerMediator(new VideoModuleMediator(app));
		}

	}
}