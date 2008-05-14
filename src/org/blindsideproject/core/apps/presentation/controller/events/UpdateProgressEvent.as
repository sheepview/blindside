package org.blindsideproject.core.apps.presentation.controller.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.presentation.controller.PresentationController;
	
	public class UpdateProgressEvent extends CairngormEvent
	{
		private var _message : String;
		
		public function UpdateProgressEvent(message : String) : void
		{
			super(PresentationController.UPDATE_PROGRESS_EVENT);
			_message = message
		}
		
		public function get message() : String
		{
			return _message;
		}
	}
}