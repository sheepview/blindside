package org.blindsideproject.core.apps.presentation.controller.handlers
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	
	import org.blindsideproject.core.apps.presentation.model.PresentationFacade;
	import org.blindsideproject.core.apps.presentation.controller.commands.UploadCommand;
	import org.blindsideproject.core.util.log.ILogger;

	import mx.rpc.IResponder;
	import org.blindsideproject.core.apps.presentation.services.FileUploadService;

		
	public class UploadCommandHandler implements ICommand
	{		
		private var model : PresentationFacade = PresentationFacade.getInstance();

		private var service : FileUploadService;
		
		public function execute(cgCommand:CairngormEvent):void
		{
			var command : UploadCommand = UploadCommand(cgCommand);
	
			service = new FileUploadService(command.url, command.room);
			service.upload(command.file);
		}
	}
}