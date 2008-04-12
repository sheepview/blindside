package model
{
	public class Ellipse extends DrawObject
	{
		public function Ellipse(segment:Array)
		{
			super();
			this.type = DrawObject.ELLIPSE;
			this.shape = segment;
		}
		
	}
}