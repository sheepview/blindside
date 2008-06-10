package org.bigbluebutton.modules.presentation.controller
{
	import org.bigbluebutton.modules.presentation.PresentationModule;
	import org.bigbluebutton.modules.presentation.PresentationModuleMediator;
	import org.bigbluebutton.modules.presentation.view.PresentationWindow;
	import org.bigbluebutton.modules.presentation.view.PresentationWindowMediator;
	import org.bigbluebutton.modules.presentation.view.ThumbnailViewMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**
	 * This command is a sub-command of the Macro Command StartupCommand. It registers various mediators that
	 * are needed when the Presentation module starts up 
	 * @author dzgonjan
	 * 
	 */	
	public class StartupViewCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			//var presentationWindow:PresentationWindow = new PresentationWindow();
			//facade.registerMediator(new PresentationWindowMediator(presentationWindow));
			//facade.registerMediator(new ThumbnailViewMediator(presentationWindow.thumbnailView));
			
			var app:PresentationModule = notification.getBody() as PresentationModule;
			facade.registerMediator(new PresentationModuleMediator(app));
		}

	}
}