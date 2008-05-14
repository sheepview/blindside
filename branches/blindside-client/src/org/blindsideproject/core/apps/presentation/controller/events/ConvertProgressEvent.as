package org.blindsideproject.core.apps.presentation.controller.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.presentation.controller.PresentationController;
	
	public class ConvertProgressEvent extends CairngormEvent
	{
		private var _totalSlides : Number;
		private var _completedSlides : Number;
		
		public function ConvertProgressEvent(totalSlides : Number, completedSlides : Number) : void
		{
			super(PresentationController.CONVERT_PROGRESS_EVENT);
			_totalSlides = totalSlides;	
			_completedSlides = completedSlides;
		}
		
		public function get totalSlides() : Number
		{
			return _totalSlides;
		}
		
		public function get completedSlides() : Number
		{
			return _completedSlides;
		}
	}
}