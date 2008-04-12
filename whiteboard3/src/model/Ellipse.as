package model
{
	public class Ellipse extends DrawObject
	{
		public function Ellipse(segment:Array, color:uint, thickness:uint)
		{
			super();
			this.type = DrawObject.ELLIPSE;
			this.shape = segment;
			this.color = color;
			this.thickness = thickness;
		}
		
	}
}