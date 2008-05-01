package org.blindsideproject.presentation.command
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	import org.blindsideproject.presentation.events.PageNumberEvent;
    import org.blindsideproject.presentation.business.*;
    import org.blindsideproject.presentation.model.*;
    
	public class PageNumberCommand implements ICommand
	{		
		private var pageNumber:Number;
				
		public function execute(cgEvent:CairngormEvent):void
		{

			var event : PageNumberEvent = PageNumberEvent( cgEvent );
				
			pageNumber = event.pageNumber;			
			model.presentation.presentationDelegate.sendPageNumber(pageNumber);
			
		}
		
        [Bindable]
        public var model : PresentationModelLocator = PresentationModelLocator.getInstance();
	}
}