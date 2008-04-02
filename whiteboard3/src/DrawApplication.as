package
{
	import model.DrawModel;
	import model.DrawModelLocator;
	
	public class DrawApplication
	{
		public var model:DrawModel;
		
		public function DrawApplication()
		{
			this.model = DrawModelLocator.getInstance();
		}

	}
}