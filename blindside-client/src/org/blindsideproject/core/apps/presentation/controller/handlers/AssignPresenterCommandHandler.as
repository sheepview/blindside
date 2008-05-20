package org.blindsideproject.core.apps.presentation.controller.handlers
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.blindsideproject.core.apps.presentation.controller.commands.AssignPresenterCommand;
	import org.blindsideproject.core.apps.presentation.model.PresentationFacade;

		
	public class AssignPresenterCommandHandler implements ICommand
	{		
		private var model :PresentationFacade = PresentationFacade.getInstance();

		public function execute(cgCommand:CairngormEvent):void
		{
			var command : AssignPresenterCommand = AssignPresenterCommand(cgCommand);
	
			model.presentationDelegate.givePresenterControl(command.userid, command.name);
		}
	}
}