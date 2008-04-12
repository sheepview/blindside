package model
{
	public class Rectangle extends DrawObject
	{
		public function Rectangle(segment:Array)
		{
			super();
			this.type = DrawObject.RECTANGLE;
			this.shape = segment;
		}
		
	}
}