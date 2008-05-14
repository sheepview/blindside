package org.blindsideproject.core.apps.presentation.controller.handlers
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	
	import org.blindsideproject.core.apps.presentation.model.PresentationModelLocator;
	import org.blindsideproject.core.apps.presentation.controller.commands.AssignPresenterCommand;
	import org.blindsideproject.core.util.log.ILogger;

	import mx.rpc.IResponder;

		
	public class AssignPresenterCommandHandler implements ICommand
	{		
		private var model : PresentationModelLocator = PresentationModelLocator.getInstance();

		public function execute(cgCommand:CairngormEvent):void
		{
			var command : AssignPresenterCommand = AssignPresenterCommand(cgCommand);
	
			model.presentationDelegate.givePresenterControl(command.userid, command.name);
		}
	}
}