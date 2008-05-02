package model
{
	public class Rectangle extends DrawObject
	{
		public function Rectangle(segment:Array, color:uint, thickness:uint)
		{
			super();
			this.type = DrawObject.RECTANGLE;
			this.shape = segment;
			this.color = color;
			this.thickness = thickness;
		}
		
	}
}