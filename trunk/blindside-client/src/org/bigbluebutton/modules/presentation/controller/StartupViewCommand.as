package org.bigbluebutton.modules.presentation.controller
{
	import org.bigbluebutton.modules.presentation.view.PresentationWindow;
	import org.bigbluebutton.modules.presentation.view.PresentationWindowMediator;
	import org.bigbluebutton.modules.presentation.view.ThumbnailViewMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class StartupViewCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			var app:PresentationWindow = notification.getBody() as PresentationWindow;
			facade.registerMediator(new PresentationWindowMediator(app));
			facade.registerMediator(new ThumbnailViewMediator(app.thumbnailView));
			//facade.registerMediator(new FileUploadWindowMediator(app.uploadWindow));
		}

	}
}