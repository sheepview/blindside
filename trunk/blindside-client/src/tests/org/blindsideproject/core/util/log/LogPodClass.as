package tests.org.blindsideproject.core.util.log
{
	 
	import mx.containers.Box;
	import mx.controls.TextArea;
	
    import org.blindsideproject.core.util.log.*
    
	public class LogPodClass extends Box
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