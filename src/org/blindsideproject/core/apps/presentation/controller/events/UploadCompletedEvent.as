package org.blindsideproject.core.apps.presentation.controller.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.presentation.controller.PresentationController;
	
	public class UploadCompletedEvent extends CairngormEvent
	{
		public function UploadCompletedEvent() : void
		{
			super(PresentationController.UPLOAD_COMPLETED_EVENT);
		}
	}
}