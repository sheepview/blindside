package util.log
{
	 
	import flexlib.mdi.containers.MDIWindow;
	
	import util.log.*;  
      
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