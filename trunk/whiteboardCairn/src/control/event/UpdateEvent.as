package control.event
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import control.DrawController;
	
	/**
	 * An empty event that gets sent to signal that an update on the client is necessary 
	 * @author Denis
	 * 
	 */	
	public class UpdateEvent extends CairngormEvent
	{
		/**
		 * The default constructor. Registers the event with the DrawController 
		 * 
		 */		
		public function UpdateEvent()
		{
			super(DrawController.UPDATE_EVENT);
		}

	}
}