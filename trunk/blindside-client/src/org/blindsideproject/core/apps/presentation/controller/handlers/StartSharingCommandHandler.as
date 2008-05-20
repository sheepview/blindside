package org.blindsideproject.core.apps.presentation.controller.handlers
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	
	import org.blindsideproject.core.apps.presentation.model.PresentationFacade;
	import org.blindsideproject.core.apps.presentation.controller.commands.StartSharingCommand;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
				
	import mx.rpc.IResponder;
	import mx.utils.ArrayUtil;
	import mx.collections.ArrayCollection;		
	import mx.collections.IViewCursor;
		
	public class StartSharingCommandHandler implements ICommand
	{		
		private var model : PresentationFacade = PresentationFacade.getInstance();
		private var log : ILogger = LoggerModelLocator.getInstance().log;
						
		public function execute(cgCommand:CairngormEvent):void
		{
			var command : StartSharingCommand = StartSharingCommand(cgCommand);
	
			log.debug("In start share command handler");
			
			model.presentationDelegate.share(true);
		}	
	}
}