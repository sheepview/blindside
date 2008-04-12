package model
{
	public class Pencil extends DrawObject
	{
		public function Pencil(segment:Array, color:uint, thickness:uint)
		{
			super();
			this.type = DrawObject.PENCIL;
			this.shape = segment;
			this.color = color;
			this.thickness = thickness;
		}
		
	}
}