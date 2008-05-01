package org.blindsideproject.util.components.logger.view
{
	 
	import mx.containers.Box;
	import mx.controls.TextArea;
	
	import org.blindsideproject.util.components.logger.model.*;
    import superpanel.nl.wv.extenders.panel.SuperPanel;
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