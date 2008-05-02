package model
{
	public class DrawObjectFactory
	{
		public function DrawObjectFactory()
		{
		}
		
		public function makeDrawObject(type:String, shape:Array, color:uint, thickness:uint):DrawObject{
			var d:DrawObject = null;
			if (type == DrawObject.PENCIL){
				d = makePencil(shape, color, thickness);
			} else if (type == DrawObject.RECTANGLE){
				d = makeRectangle(shape, color, thickness);
			} else if (type == DrawObject.ELLIPSE){
				d = makeEllipse(shape, color, thickness);
			}
			return d;
		}
		
		public function makePencil(shape:Array, color:uint, thickness:uint):DrawObject{
			return new Pencil(shape, color, thickness);
		}
		
		public function makeRectangle(shape:Array, color:uint, thickness:uint):DrawObject{
			return new Rectangle(shape, color, thickness);
		}
		
		public function makeEllipse(shape:Array, color:uint, thickness:uint):DrawObject{
			return new Ellipse(shape, color, thickness);
		}

	}
}