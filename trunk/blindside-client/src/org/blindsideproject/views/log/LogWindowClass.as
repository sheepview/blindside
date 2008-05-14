package org.blindsideproject.views.log
{
	 
	import flexlib.mdi.containers.MDIWindow;
	
	import org.blindsideproject.core.util.log.*;  
      
	public class LogWindowClass extends MDIWindow
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
	}
}