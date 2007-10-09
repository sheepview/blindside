package org.blindsideproject.core.apps.presentation.controller.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.presentation.controller.PresentationController;
	import org.blindsideproject.core.apps.presentation.controller.*;
	
	public class GotoPageCommand extends CairngormEvent
	{	
		private var _page : Number;
		
		public function GotoPageCommand(page : Number) : void
		{
			super(PresentationController.GOTO_PAGE_COMMAND);
			_page = page
		}
		
		public function get page() : Number
		{
			return _page;
		}
	}
}