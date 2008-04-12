package model
{
	import flash.display.Shape;
	
	public class ShapeFactory
	{
		private var drawFactory:DrawObjectFactory;
		
		public function ShapeFactory()
		{
			drawFactory = new DrawObjectFactory();
		}
		
		public function makeShape(shape:DrawObject):Shape{
			var s:Shape = null;
			if (shape.getType() == DrawObject.PENCIL){
				s = makePencil(Pencil(shape));
			} else if (shape.getType() == DrawObject.RECTANGLE){
				s = makeRectangle(Rectangle(shape));
			} else if (shape.getType() == DrawObject.ELLIPSE){
				s = makeEllipse(Ellipse(shape));
			}
			return s;
		}
		
		public function makePencil(p:Pencil):Shape{
			var newShape:Shape = new Shape();
			newShape.graphics.lineStyle(2);
            
	            for (var c:Number = 2; c < p.getShapeArray().length ; c += 2){
	            	newShape.graphics.moveTo(p.getShapeArray()[c-2], p.getShapeArray()[c-1]);
	            	newShape.graphics.lineTo(p.getShapeArray()[c],p.getShapeArray()[c+1]);
	            }
	            
	        return newShape;
		}
		
		public function makeFeedback(segment:Array, type:String):Shape{
			return makeShape(drawFactory.makeDrawObject(type,segment));
		}
		
		public function makeRectangle(r:Rectangle):Shape{
			var newShape:Shape = new Shape();
			newShape.graphics.lineStyle(2);
			var arrayEnd:Number = r.getShapeArray().length;
			var x:Number = r.getShapeArray()[0];
			var y:Number = r.getShapeArray()[1];
			var width:Number = r.getShapeArray()[arrayEnd-2] - x;
			var height:Number = r.getShapeArray()[arrayEnd-1] - y;
			
			newShape.graphics.drawRect(x,y,width,height);
			
			return newShape;	
		}
		
		public function makeEllipse(e:Ellipse):Shape{
			var newShape:Shape = new Shape();
			newShape.graphics.lineStyle(2);
			var arrayEnd:Number = e.getShapeArray().length;
			var x:Number = e.getShapeArray()[0];
			var y:Number = e.getShapeArray()[1];
			var width:Number = e.getShapeArray()[arrayEnd-2] - x;
			var height:Number = e.getShapeArray()[arrayEnd-1] - y;
			
			newShape.graphics.drawEllipse(x,y,width,height);
			
			return newShape;
		}

	}
}