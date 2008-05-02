package model
{
	import vo.DrawVO;
	
	/**
	 * The DrawModel holds the ValueObjects for the Whiteboard application 
	 * @author Denis
	 * 
	 */	
	public class DrawModel
	{
		public var drawVO:DrawVO;
		
		/**
		 * The default constructor. Instantiates the Value ObjectsS 
		 * 
		 */		
		public function DrawModel()
		{
			this.drawVO = new DrawVO();
		}

	}
}