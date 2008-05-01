package org.blindsideproject.presentation.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.presentation.control.PresentationController;
	
	public class PageNumberEvent extends CairngormEvent
	{
		public var pageNumber:Number;
		
		public function PageNumberEvent(pageNumber:Number)
		{
			super(PresentationController.EVENT_PAGE_NUMBER);
			this.pageNumber=pageNumber;
		}
	}
}