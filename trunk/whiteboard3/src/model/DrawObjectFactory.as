package model
{
	public class DrawObjectFactory
	{
		public function DrawObjectFactory()
		{
		}
		
		public function makeDrawObject(type:String, shape:Array):DrawObject{
			var d:DrawObject = null;
			if (type == DrawObject.PENCIL){
				d = makePencil(shape);
			} else if (type == DrawObject.RECTANGLE){
				d = new Rectangle(shape);
			} else if (type == DrawObject.ELLIPSE){
				d = new Ellipse(shape);
			}
			return d;
		}
		
		public function makePencil(shape:Array):DrawObject{
			return new Pencil(shape);
		}
		
		public function makeRectangle(shape:Array):DrawObject{
			return new Rectangle(shape);
		}
		
		public function makeEllipse(shape:Array):DrawObject{
			return new Ellipse(shape);
		}

	}
}