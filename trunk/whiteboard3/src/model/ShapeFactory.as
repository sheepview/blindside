package model
{
	import flash.display.Shape;
	
	public class ShapeFactory
	{
		public function ShapeFactory()
		{
		}
		
		public static function makeShape(shape:DrawObject):Shape{
			var s:Shape = null;
			if (shape.isPrototypeOf(Pencil)){
				s = makePencil(Pencil(shape));
			}
			return makePencil(Pencil(shape));
		}
		
		public static function makePencil(p:Pencil):Shape{
			var newShape:Shape = new Shape();
			newShape.graphics.lineStyle(2);
            
	            for (var c:Number = 2; c < p.getShapeArray().length ; c += 2){
	            	newShape.graphics.moveTo(p.getShapeArray()[c-2], p.getShapeArray()[c-1]);
	            	newShape.graphics.lineTo(p.getShapeArray()[c],p.getShapeArray()[c+1]);
	            }
	            
	        return newShape;
		}

	}
}