package org.bigbluebutton.modules.presentation.controller
{
	import org.puremvc.as3.multicore.patterns.command.MacroCommand;
	
	/**
	 * This MacroCommand is called at startup. It calls two other sub-commands: StartupModelCommand and
	 * StartupViewCommand 
	 * @author dzgonjan
	 * 
	 */	
	public class StartupCommand extends MacroCommand
	{
		override protected function initializeMacroCommand():void{
			addSubCommand(StartupModelCommand);
			addSubCommand(StartupViewCommand);
		}

	}
}