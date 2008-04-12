package model
{
	public class DrawObject
	{
		public static const PENCIL:String = "pencil";
		public static const RECTANGLE:String = "rectangle";
		public static const ELLIPSE:String = "ellipse";
		
		protected var type:String;
		protected var shape:Array;
		protected var color:uint;
		protected var thickness:uint;
		
		public function DrawObject()
		{
		}
		
		public function getType():String{
			return this.type;
		}
		
		public function getShapeArray():Array{
			return this.shape;
		}
		
		public function getColor():uint{
			return this.color;
		}
		
		public function getThickness():uint{
			return this.thickness;
		}

	}
}