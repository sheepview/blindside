package org.bigbluebutton.modules.presentation.controller
{
	import org.bigbluebutton.modules.presentation.view.FileUploadWindow;
	import org.bigbluebutton.modules.presentation.view.FileUploadWindowMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class StartUploadWindowCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			var window:FileUploadWindow = notification.getBody() as FileUploadWindow;
			facade.registerMediator(new FileUploadWindowMediator(window));
		}

	}
}