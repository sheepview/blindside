package view
{
	import control.command.SendShapeCommand;
	
	import model.DrawModelLocator;
	
	import mx.containers.Panel;
	
	import vo.DrawVO;

	/**
	 * A superclass of the GUI component of the application 
	 * @author Denis
	 * 
	 */	
	public class BoardClass extends Panel
	{
		protected var boardModel:DrawModelLocator = DrawModelLocator.getInstance();
		[Bindable]
		public var drawVO:DrawVO = boardModel.draw.drawVO;
		
		/**
		 * The default constructor. 
		 * 
		 */		
		public function BoardClass()
		{
			super();
			boardModel.getDrawDelegate();
		}
		
		/**
		 * Dispatches a shape drawn on the screen to the DrawDelegate, which updates all the client applications.
		 * <p>
		 * NOTE: Since shared objects don't support graphical objects (Shapes) being stored into them, the shapes have
		 * to be converted into a collection of coordinates and reconstructed on the client. This adds some overhead,
		 * but it necessary.
		 * @param shape The array representation of the shape that was drawn
		 * 
		 */		
		public function sendShape(shape:Array):void{
			var cgCommand : SendShapeCommand = new SendShapeCommand(shape);
			cgCommand.dispatch();
		}
		
	}
}