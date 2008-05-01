package org.blindsideproject.core.apps.presentation.controller.handlers
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	
	import org.blindsideproject.core.apps.presentation.model.PresentationModelLocator;
	import org.blindsideproject.core.apps.presentation.controller.commands.JoinCommand;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
	
	import mx.rpc.IResponder;
	import com.adobe.cairngorm.commands.SequenceCommand;
	import org.blindsideproject.core.apps.presentation.controller.commands.LoadCommand;;

		
	public class JoinCommandHandler extends SequenceCommand
	{		
		private var model : PresentationModelLocator = PresentationModelLocator.getInstance();
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		
		public function JoinCommandHandler() : void
		{
			nextEvent = new LoadCommand("test");
			
		}
		override public function execute(cgCommand:CairngormEvent):void
		{
			var command : JoinCommand = JoinCommand(cgCommand);
	
			log.debug("Joining presentation");
			
			model.presentationDelegate.join(command.userid, command.host, command.room);
			
		}
	}
}