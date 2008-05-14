package org.blindsideproject.core.apps.presentation.model
{
	import com.adobe.cairngorm.model.IModelLocator;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.apps.presentation.business.PresentationDelegate;
		
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.*
	import com.adobe.cairngorm.control.FrontController;
	import org.blindsideproject.core.apps.presentation.controller.PresentationController;
	
	public class PresentationModelLocator implements IModelLocator
	{
		public static const ID : String = "org.blindsideproject.core.apps.presentation.model.PresentationModelLocator";

		private var _log : ILogger = LoggerModelLocator.getInstance().log;		
		private var _dispatcher : CairngormEventDispatcher = CairngormEventDispatcher.getInstance();
		private var _controller : FrontController = null;
		
		private static var instance : PresentationModelLocator;
		
		private var _presentationDelegate : PresentationDelegate = null;	
			
		[Bindable]
		public var presentation : PresentationModel = new PresentationModel();
		
		public function PresentationModelLocator() : void
		{
			if ( instance != null ) {
					throw new CairngormError(
					   CairngormMessageCodes.SINGLETON_EXCEPTION, "PresentationModelLocator" );
			}
			
			initialize();		
		}

		public static function getInstance() : PresentationModelLocator
		{
			if ( instance == null )
				instance = new PresentationModelLocator();
				
			return instance;
	   	}	

	   	private function initialize() : void
	   	{		
	   		_controller = new PresentationController();
	   	}	   	
  	
	   	public function get dispatcher() : CairngormEventDispatcher
	   	{
	   		return _dispatcher;
	   	}
	   	
	   	public function get presentationDelegate() : PresentationDelegate
	   	{
	   		if (_presentationDelegate == null) {
	   			_presentationDelegate = new PresentationDelegate();
	   		}
	   		
	   		return _presentationDelegate;
	   	}
	}
}