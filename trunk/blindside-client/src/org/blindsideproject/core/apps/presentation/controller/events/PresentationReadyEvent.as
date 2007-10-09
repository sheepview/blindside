package org.blindsideproject.core.apps.presentation.controller.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.presentation.controller.PresentationController;
	
	public class PresentationReadyEvent extends CairngormEvent
	{
		public function PresentationReadyEvent() : void
		{
			super(PresentationController.READY_EVENT);
		}
	}
}