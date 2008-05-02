package view
{
	import control.command.SendShapeCommand;
	
	import model.DrawModelLocator;
	import model.DrawObject;
	import model.DrawObjectFactory;
	import model.ShapeFactory;
	
	import mx.containers.Panel;
	
	import vo.DrawVO;

	/**
	 * A superclass of the GUI component of the application.
	 * <p>
	 * The application is implemented using the Cairngorm Framework
	 * @author Denis
	 * 
	 */	
	public class BoardClass extends Panel
	{
		protected var boardModel:DrawModelLocator = DrawModelLocator.getInstance();
		[Bindable]
		public var drawVO:DrawVO = boardModel.draw.drawVO;
		
		protected var drawFactory:DrawObjectFactory;
		protected var shapeFactory:ShapeFactory;
		
		protected var shapeStyle:String = DrawObject.PENCIL;
		protected var drawColor:uint;
		protected var thickness:uint;
		
		/**
		 * The default constructor. 
		 * 
		 */		
		public function BoardClass()
		{
			super();
			boardModel.getDrawDelegate();
			drawFactory = new DrawObjectFactory();
			shapeFactory = new ShapeFactory();
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
		protected function sendShape(shape:DrawObject):void{
			var cgCommand : SendShapeCommand = new SendShapeCommand(shape);
			cgCommand.dispatch();
		}
		
		/**
		 * Sets the type of shape we're drawing (pencil, rectangle, etc...) 
		 * @param s The type
		 * 
		 */		
		protected function setShape(s:String):void{
			this.shapeStyle = s;
		}
		
		/**
		 * Sets the color 
		 * @param e event containing the color (e.target.selectedColor)
		 * 
		 */		
		protected function changeColor(e:Event):void{
			drawColor = e.target.selectedColor;
		}
		
		/**
		 * Sets the thickness 
		 * @param e event containing the thickness (e.target.value)
		 * 
		 */		
		protected function changeThickness(e:Event):void{
			this.thickness = e.target.value;
		}
	
	}
}