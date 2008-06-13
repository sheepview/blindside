package org.bigbluebutton.main.controller
{
	import org.bigbluebutton.main.view.MainApplicationShellMediator;
	import org.bigbluebutton.main.view.components.MainApplicationShell;
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	/**
	 * 
	 * Registers the main mediator with the main facade
	 * 
	 */    
	public class StartupCommand extends SimpleCommand implements ICommand
	{	
		override public function execute(note:INotification):void
		{
			var app:MainApplicationShell = note.getBody() as MainApplicationShell;
			facade.registerMediator( new MainApplicationShellMediator( app ) );			
		}		
	}
}