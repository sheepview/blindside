package view
{
	import control.command.SendShapeCommand;
	
	import model.DrawModelLocator;
	
	import mx.containers.Panel;
	
	import vo.DrawVO;

	public class BoardClass extends Panel
	{
		protected var boardModel:DrawModelLocator = DrawModelLocator.getInstance();
		[Bindable]
		public var drawVO:DrawVO = boardModel.draw.drawVO;
		
		public function BoardClass()
		{
			super();
			boardModel.getDrawDelegate();
		}
		
		public function setup():void{
		
		}
		
		public function sendShape(shape:Array):void{
			var cgCommand : SendShapeCommand = new SendShapeCommand(shape);
			cgCommand.dispatch();
		}
		
	}
}