package model
{
	public class DrawObjectFactory
	{
		public function DrawObjectFactory()
		{
		}
		
		public static function makeDrawObject(type:String, shape:Array):DrawObject{
			var d:DrawObject = null;
			if (type == DrawObject.PENCIL){
				d = makePencil(shape);
			}
			return d;
		}
		
		public static function makePencil(shape:Array):DrawObject{
			return new Pencil(shape);
		}

	}
}