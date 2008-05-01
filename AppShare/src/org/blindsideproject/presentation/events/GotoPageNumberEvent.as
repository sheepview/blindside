package org.blindsideproject.presentation.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.presentation.control.PresentationController;
	
	public class GotoPageNumberEvent extends CairngormEvent
	{
		public var pageNumber:Number;
		
		public function GotoPageNumberEvent(pageNumber:Number)
		{
			super(PresentationController.GOTO_PAGE_NUMBER_EVENT);
			this.pageNumber=pageNumber;
		}
		
		public function getNewPageNumber() : Number
		{
			return pageNumber;
		}
	}
}