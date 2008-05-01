package org.blindsideproject.presentation.control
{
	import com.adobe.cairngorm.control.FrontController;
	import org.blindsideproject.presentation.command.*;
	
	public class PresentationController extends FrontController
	{
		public static const EVENT_PAGE_NUMBER : String = "EVENT_PAGE_NUMBER";
		public static const GOTO_PAGE_NUMBER_EVENT : String = "GOTO_PAGE_NUMBER_EVENT";
		public static const UPLOAD_COMPLETED_EVENT : String = "UPLOAD_COMPLETED_EVENT";
		
		public function PresentationController():void
		{
			addCommand( PresentationController.EVENT_PAGE_NUMBER, PageNumberCommand );
		}
	}
}