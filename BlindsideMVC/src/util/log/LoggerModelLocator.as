package util.log
{
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	
	[Bindable]
	public class LoggerModelLocator extends Facade implements IFacade
	{
		
		public var log : Logger = new Logger();
	   	 
		/**
		 * 
		 * @return ModelLocator
		 */		
		public static function getInstance() : LoggerModelLocator
		{
			if ( instance == null )
				instance = new LoggerModelLocator();
				
			return instance as LoggerModelLocator;
	   	}
	}
}