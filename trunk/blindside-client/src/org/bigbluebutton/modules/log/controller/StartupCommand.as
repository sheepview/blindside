package org.bigbluebutton.modules.log.controller
{
	import org.bigbluebutton.modules.log.LogApplicationFacade;
	import org.bigbluebutton.modules.log.view.LogModuleMediator;
	import org.bigbluebutton.modules.log.view.components.LogModule;
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class StartupCommand extends SimpleCommand implements ICommand
	{		
		override public function execute(note:INotification):void
		{
			var app:LogModule = note.getBody() as LogModule;
			facade.registerMediator( new LogModuleMediator( app ) );
			sendNotification( LogApplicationFacade.MODULE_STARTED );
		}		
	}
}