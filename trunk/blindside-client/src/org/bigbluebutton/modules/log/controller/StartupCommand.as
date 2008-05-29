package org.bigbluebutton.modules.log.controller
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.interfaces.INotification;

	public class StartupCommand extends SimpleCommand implements ICommand
	{
		
		override public function execute(notification:INotification):void
		{
			
		}
		
	}
}