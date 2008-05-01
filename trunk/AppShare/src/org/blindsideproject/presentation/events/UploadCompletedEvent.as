package org.blindsideproject.presentation.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.presentation.control.PresentationController;
	
	public class UploadCompletedEvent extends CairngormEvent
	{
		public function UploadCompletedEvent() {
			super(PresentationController.UPLOAD_COMPLETED_EVENT);
		}
	}
}