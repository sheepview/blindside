package model
{
	public class Ellipse extends DrawObject
	{
		/**
		 * 
		 * @param segment The arrray representation of the drawObject
		 * @param color
		 * @param thickness
		 * 
		 */		
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