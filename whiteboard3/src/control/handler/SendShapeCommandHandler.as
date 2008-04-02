package control.handler
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import control.command.SendShapeCommand;
	
	import model.DrawModelLocator;
	
	public class SendShapeCommandHandler implements ICommand
	{
		private var boardModel:DrawModelLocator = DrawModelLocator.getInstance();
		
		public function execute(cgCommand:CairngormEvent):void
		{
			var command:SendShapeCommand = SendShapeCommand(cgCommand);
			boardModel.getDrawDelegate().sendShape(command.getSegment());
		}

	}
}