package org.blindsideproject.util.components.logger.view
{
	 
	import mx.containers.ApplicationControlBar;

	import org.blindsideproject.util.components.logger.model.*;
	
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
		public var log : Logger = model.log;
		
	}
}