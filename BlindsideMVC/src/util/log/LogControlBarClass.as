package util.log
{
	 
	import mx.containers.ApplicationControlBar;	
	import util.log.*;
	
	public class LogControlBarClass extends ApplicationControlBar
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
		 * 
		 */		
		public function clearLog () : void 
		{
			// Remove all text from logger panel.
			log.statusText = "";
			// Display Flash Player version info.
			log.info( log.flashVersion);
		}
	}
}