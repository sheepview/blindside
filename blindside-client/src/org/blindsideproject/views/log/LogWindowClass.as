package org.blindsideproject.views.log
{
	 
	import mx.containers.Box;
	import mx.controls.TextArea;
	
	import org.blindsideproject.core.util.log.*;
    import org.blindsideproject.core.util.log.*

    import flexmdi.containers.MDIWindow;  
      
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