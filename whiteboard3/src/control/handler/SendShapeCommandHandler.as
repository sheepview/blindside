package control.handler
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import control.command.SendShapeCommand;
	
	import model.DrawModelLocator;
	
	/**
	 * This class handles a Send Shape command, by calling an appropriate methos in the DrawDelegate 
	 * @author Denis
	 * 
	 */	
	public class SendShapeCommandHandler implements ICommand
	{
		private var boardModel:DrawModelLocator = DrawModelLocator.getInstance();
		
		/**
		 * This method is executed automaticaly once the DrawController recognizes a Send Shape command 
		 * @param cgCommand
		 * 
		 */		
		public function execute(cgCommand:CairngormEvent):void
		{
			var command:SendShapeCommand = SendShapeCommand(cgCommand);
			boardModel.getDrawDelegate().sendShape(command.getSegment());
		}

	}
}