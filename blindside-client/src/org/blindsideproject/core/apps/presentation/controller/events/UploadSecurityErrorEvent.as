package org.blindsideproject.core.apps.presentation.controller.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.presentation.controller.PresentationController;
	
	public class UploadSecurityErrorEvent extends CairngormEvent
	{
		private var _message : String;
		
		public function UploadSecurityErrorEvent(message : String) : void
		{
			super(PresentationController.UPLOAD_SECURITY_ERROR_EVENT);
			_message = message;	
		}
		
		public function get message() : String
		{
			return _message;
		}
	}
}