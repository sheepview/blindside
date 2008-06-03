package org.bigbluebutton.modules.presentation.controller
{
	import flash.net.NetConnection;
	
	import org.bigbluebutton.modules.presentation.model.PresentationApplication;
	import org.bigbluebutton.modules.presentation.model.PresentationModel;
	import org.bigbluebutton.modules.presentation.model.business.PresentationDelegate;
	import org.bigbluebutton.modules.presentation.view.PresentationWindow;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**
	 * This command is a sub-command of the Macro Command StartupCommand. It registers a PresentationDelegate
	 * Proxy class with the PresentationFacade 
	 * @author dzgonjan
	 * 
	 */	
	public class StartupModelCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			var app:PresentationWindow = notification.getBody() as PresentationWindow;
			facade.registerProxy(new PresentationDelegate(new NetConnection()));
			facade.registerMediator(new PresentationModel());
		}

	}
}