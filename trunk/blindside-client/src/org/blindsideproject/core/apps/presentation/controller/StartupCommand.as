package org.blindsideproject.core.apps.presentation.controller
{
	import org.puremvc.as3.multicore.patterns.command.MacroCommand;
	
	public class StartupCommand extends MacroCommand
	{
		override protected function initializeMacroCommand():void{
			addSubCommand(StartupViewCommand);
			addSubCommand(StartupModelCommand);
		}

	}
}