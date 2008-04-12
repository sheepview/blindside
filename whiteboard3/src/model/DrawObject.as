package model
{
	public class DrawObject
	{
		public static const PENCIL:String = "pencil";
		public static const RECTANGLE:String = "rectangle";
		public static const ELLIPSE:String = "ellipse";
		
		protected var type:String;
		protected var shape:Array;
		
		public function DrawObject()
		{
		}
		
		public function getType():String{
			return this.type;
		}
		
		public function getShapeArray():Array{
			return this.shape;
		}

	}
}