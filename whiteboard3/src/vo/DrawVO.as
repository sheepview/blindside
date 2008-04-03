package vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	/**
	 * A ValueObject which holds the shapes being drawn on the screen
	 * @author Denis
	 * 
	 */	
	[Bindable]
	public class DrawVO implements IValueObject
	{
		public var segment:Array;
		
		public function DrawVO()
		{
		}

	}
}