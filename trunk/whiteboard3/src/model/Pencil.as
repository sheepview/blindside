package model
{
	public class Pencil extends DrawObject
	{
		public function Pencil(segment:Array)
		{
			super();
			this.type = DrawObject.PENCIL;
			this.shape = segment;
		}
		
	}
}