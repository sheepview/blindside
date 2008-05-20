package org.blindsideproject.core.apps.presentation.controller.handlers
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	
	import org.blindsideproject.core.apps.presentation.model.PresentationFacade;
	import org.blindsideproject.core.apps.presentation.controller.commands.LeaveCommand;
	import org.blindsideproject.core.util.log.ILogger;

	import mx.rpc.IResponder;

		
	public class LeaveCommandHandler implements ICommand
	{		
		private var model : PresentationFacade = PresentationFacade.getInstance();

		public function execute(cgCommand:CairngormEvent):void
		{
			var command : LeaveCommand = LeaveCommand(cgCommand);
	
			model.presentationDelegate.leave();
		}
	}
}