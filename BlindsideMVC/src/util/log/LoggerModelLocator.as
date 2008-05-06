package util.log
{
	import com.adobe.cairngorm.model.IModelLocator;
	import com.adobe.cairngorm.*;
	
	[Bindable]
	public class LoggerModelLocator implements IModelLocator
	{
		private static var instance : LoggerModelLocator;
		
		public var log : Logger;
		
	   	public function LoggerModelLocator() 
	   	{
	   		if ( instance != null )
					throw new CairngormError(
					   CairngormMessageCodes.SINGLETON_EXCEPTION, "LoggerModelLocator" );
					
				initialize();
	   	}
	   	
		/**
		 * 
		 * @return ModelLocator
		 */		
		public static function getInstance() : LoggerModelLocator
		{
			if ( instance == null )
				instance = new LoggerModelLocator();
				
			return instance;
	   	}
	   	
	   	/**
	   	 * 
	   	 */	   	
	   	private function initialize() : void
	   	{
			log = new Logger();
	   	}		
	}
}