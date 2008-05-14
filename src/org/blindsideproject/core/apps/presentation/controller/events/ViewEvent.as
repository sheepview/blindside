package org.blindsideproject.core.apps.presentation.controller.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.presentation.controller.PresentationController;
	
	public class ViewEvent extends CairngormEvent
	{
		public function ViewEvent() : void
		{
			super(PresentationController.VIEW_EVENT);
		}
	}
}