package org.blindsideproject.views.log
{
	 
	import mx.containers.ViewStack;
	import mx.controls.TextArea;
	
	import org.blindsideproject.core.util.log.*;
	
	public class LogDisplayClass extends ViewStack
	{
		/**
		* 
		*/		
		private var model : LoggerModelLocator = LoggerModelLocator.getInstance();
		
		[Bindable]
		/**
		* 
		*/		
		public var log : Logger = model.log;
		
		/**
		* 
		*/		
		public var status_txt : TextArea;
		
		/**
		 * 
		 * 
		 */		
		public function updateScroll () : void 
		{
			//
			status_txt.verticalScrollPosition = status_txt.maxVerticalScrollPosition;
		}
	}
}