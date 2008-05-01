package org.blindsideproject.presentation.model
{
	import com.adobe.cairngorm.model.IModelLocator;
	import org.blindsideproject.presentation.vo.*;
	import mx.events.IndexChangedEvent;
	import com.adobe.cairngorm.*;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import org.blindsideproject.util.components.logger.model.*;
	
	public class PresentationModelLocator implements IModelLocator
	{
		private var dispatcher : CairngormEventDispatcher = CairngormEventDispatcher.getInstance();
		
		private static var modelLocator : PresentationModelLocator;
		
		private var log : Logger = LoggerModelLocator.getInstance().log;
		
		public var presentationVO:PresentationVO;
	   	public var presentation:Presentation;
		
		/**
	   	 * @throws CairngormError Only one ModelLocator instance should be instantiated.
	   	 */	   	
	   	public function PresentationModelLocator() : void
	   	{
	   		if ( modelLocator != null )
					throw new CairngormError(
					   CairngormMessageCodes.SINGLETON_EXCEPTION, "PresentationModelLocator" );		
	   	}
	   	
	   	
		/**
		 * 
		 * @return ModelLocator
		 */		
		public static function getInstance() : PresentationModelLocator
		{
			if ( modelLocator == null )
				modelLocator = new PresentationModelLocator();
				
			return modelLocator;
	   	}
	   	  		   	
	   	public function getDispatcher() : CairngormEventDispatcher
	   	{
	   		return dispatcher;
	   	}
	   	public function getLogger() : Logger
	   	{
	   		return log;
	   	}
	   	
	   	public function setupPresentation() : void
	   	{
			presentationVO = new PresentationVO();
			presentation = new Presentation();		   		
	   	}
	}
}