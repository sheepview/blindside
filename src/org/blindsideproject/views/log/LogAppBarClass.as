package org.blindsideproject.views.log
{
	 
	import mx.containers.ApplicationControlBar;

	import org.blindsideproject.core.util.log.*;
	
	public class LogAppBarClass extends ApplicationControlBar
	{
		/**
		* 
		*/		
		private var model : LoggerModelLocator = LoggerModelLocator.getInstance();
		
		[Bindable]
		/**
		* 
		*/
		public var log : ILogger = model.log;
		
	}
}