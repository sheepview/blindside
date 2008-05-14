package org.blindsideproject.views.log
{
	 
	import flexlib.mdi.containers.MDIWindow;
	
	import org.blindsideproject.core.util.log.*;    
	public class LogPodClass extends MDIWindow
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