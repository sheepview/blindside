package control.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import control.DrawController;
	
	public class UpdateEvent extends CairngormEvent
	{
		public function UpdateEvent()
		{
			super(DrawController.UPDATE_EVENT);
		}

	}
}