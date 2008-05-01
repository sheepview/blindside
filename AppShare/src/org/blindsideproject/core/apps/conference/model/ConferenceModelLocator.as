package org.blindsideproject.core.apps.conference.model
{
	import com.adobe.cairngorm.model.IModelLocator;
	import org.blindsideproject.core.util.log.*;

	import org.blindsideproject.core.apps.conference.business.ConferenceDelegate;
		
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.*
	import com.adobe.cairngorm.control.FrontController;
	import org.blindsideproject.core.apps.conference.controller.ConferenceController;
	import org.blindsideproject.core.apps.conference.model.ConferenceModel;
	
	public class ConferenceModelLocator implements IModelLocator
	{
		public static const ID : String = "ConferenceModelLocator";

		private var _log : ILogger = LoggerModelLocator.getInstance().log;		
		private var _dispatcher : CairngormEventDispatcher = CairngormEventDispatcher.getInstance();
		private var _controller : FrontController = null;
		
		private static var instance : ConferenceModelLocator;
		
		private var _conferenceDelegate : ConferenceDelegate = null;	
			
		[Bindable]
		public var conference : ConferenceModel = new ConferenceModel();
		
		public function ConferenceModelLocator() : void
		{
			if ( instance != null ) {
					throw new CairngormError(
					   CairngormMessageCodes.SINGLETON_EXCEPTION, "ConferenceModelLocator" );
			}
			
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
	   		_controller = new ConferenceController();
	   	}	   	
  	
	   	public function get dispatcher() : CairngormEventDispatcher
	   	{
	   		return _dispatcher;
	   	}
	   	
	   	public function get log() : ILogger
	   	{
	   		return _log;
	   	}
	   	
	   	public function get conferenceDelegate() : ConferenceDelegate
	   	{
	   		if (_conferenceDelegate == null) {
	   			_conferenceDelegate = new ConferenceDelegate();
	   		}
	   		
	   		return _conferenceDelegate;
	   	}
	}
}