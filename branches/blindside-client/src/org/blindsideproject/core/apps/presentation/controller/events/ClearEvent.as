package org.blindsideproject.core.apps.presentation.controller.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.presentation.controller.PresentationController;
	
	public class ClearEvent extends CairngormEvent
	{
		public function ClearEvent() : void
		{
			super(PresentationController.CLEAR_EVENT);
		}
	}
}