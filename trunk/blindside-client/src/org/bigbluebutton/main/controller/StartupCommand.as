package org.bigbluebutton.main.controller
{
	import org.bigbluebutton.main.view.MainApplicationShellMediator;
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class StartupCommand extends SimpleCommand implements ICommand
	{	
		override public function execute(note:INotification):void
		{
			var app:BigBlueButton = note.getBody() as BigBlueButton;
			facade.registerMediator( new MainApplicationShellMediator( app.mainShell ) );			
		}		
	}
}