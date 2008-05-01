package org.blindsideproject.conference.model
{
	import com.adobe.cairngorm.model.IModelLocator;
	import com.adobe.cairngorm.*;

	import org.blindsideproject.util.components.logger.model.*;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
		
	[Bindable]
	public class ConferenceModelLocator implements IModelLocator
	{
		private static var instance : ConferenceModelLocator;
		private var log : Logger = LoggerModelLocator.getInstance().log;
		
		// Dispatcher to send events to UIs
		private var dispatcher : CairngormEventDispatcher = CairngormEventDispatcher.getInstance();
				
		private var manager : ConferenceManager;
		
		public function ConferenceModelLocator()
		{
	   		if ( instance != null )
					throw new CairngormError(
					   CairngormMessageCodes.SINGLETON_EXCEPTION, "ConferenceModelLocator" );
					
				initialize();			
		}
		
		public static function getInstance() : ConferenceModelLocator
		{
			if ( instance == null )
				instance = new ConferenceModelLocator();
				
			return instance;
	   	}		
		
	   	private function initialize() : void
	   	{
	   		manager = new ConferenceManager();
	   	}	
	   	
	   	public function getConferenceManager() : ConferenceManager
	   	{
	   		return manager;
	   	}
	   	
	   	public function getLogger() : Logger
	   	{
	   		return log;
	   	}
	   	
	   	public function getDispatcher() : CairngormEventDispatcher
	   	{
	   		return dispatcher;
	   	}
	}
}