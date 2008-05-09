package util.log
{
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	[Bindable]
	public class LoggerModelLocator extends Facade implements IFacade
	{
		
		public var log : Logger = new Logger();
	   	 
	   	
	   	public static const NAME:String = "LoggerModelLocator";
	   	
	   	public function LoggerModelLocator(){
	   		super(LoggerModelLocator.NAME);
	   	}
	   	
		/**
		 * 
		 * @return ModelLocator
		 */		
		public static function getInstance() : LoggerModelLocator
		{
			if ( instanceMap[NAME] == null )
				instanceMap[NAME] = new LoggerModelLocator();
				
			return instanceMap[NAME] as LoggerModelLocator;
	   	}
	}
}