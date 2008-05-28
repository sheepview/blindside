package org.bigbluebutton.modules.presentation.controller
{
	import org.blindsideproject.views.presentation.FileUploadWindow;
	import org.blindsideproject.views.presentation.FileUploadWindowMediator;
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