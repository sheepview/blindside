package org.blindsideproject.core.apps.presentation.controller.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.presentation.controller.PresentationController;
	
	public class UploadProgressEvent extends CairngormEvent
	{
		private var _percentUploaded : Number;
		
		public function UploadProgressEvent(percentage : Number) : void
		{
			super(PresentationController.UPLOAD_PROGRESS_EVENT);
			_percentUploaded = percentage;	
		}
		
		public function get percentUploaded() : Number
		{
			return _percentUploaded;
		}
	}
}