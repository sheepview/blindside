package org.blindsideproject.views.log
{
	 
	import mx.containers.Box;
	import mx.controls.TextArea;
	
	import org.blindsideproject.core.util.log.*;
    import superpanel.nl.wv.extenders.panel.SuperPanel;
    import org.blindsideproject.core.util.log.*
    
	public class LogPodClass extends SuperPanel
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