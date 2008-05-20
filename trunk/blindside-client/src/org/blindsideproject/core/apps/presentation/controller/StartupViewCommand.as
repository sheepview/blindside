package org.blindsideproject.core.apps.presentation.controller
{
	import org.blindsideproject.views.presentation.FileUploadWindowMediator;
	import org.blindsideproject.views.presentation.PresentationWindow;
	import org.blindsideproject.views.presentation.PresentationWindowMediator;
	import org.blindsideproject.views.presentation.ThumbnailViewMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class StartupViewCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			var app:PresentationWindow = notification as PresentationWindow;
			facade.registerMediator(new PresentationWindowMediator(app));
			facade.registerMediator(new ThumbnailViewMediator(app.thumbnailView));
			facade.registerMediator(new FileUploadWindowMediator(app.uploadWindow));
		}

	}
}