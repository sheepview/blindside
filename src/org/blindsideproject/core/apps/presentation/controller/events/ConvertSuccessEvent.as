package org.blindsideproject.core.apps.presentation.controller.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.presentation.controller.PresentationController;
	
	public class ConvertSuccessEvent extends CairngormEvent
	{
		private var _message : String;
		
		public function ConvertSuccessEvent(message : String) : void
		{
			super(PresentationController.CONVERT_SUCCESS_EVENT);
			_message = message
		}
		
		public function get message() : String
		{
			return _message;
		}
	}
}