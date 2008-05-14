package org.red5.samples.publisher.model
{
	 
	import com.adobe.cairngorm.*;
	import com.adobe.cairngorm.model.IModelLocator;
	import org.red5.samples.publisher.control.PublisherController;
	import org.red5.samples.publisher.business.NetworkConnectionDelegate;
	
 	[Bindable]
	public class PublisherModelLocator implements IModelLocator
	{	
		private static var instance : PublisherModelLocator;
		
		public var model : PublisherModel = new PublisherModel();
		public var netConnDelegate : NetworkConnectionDelegate;
				
		private var pubController : PublisherController;
		 	
	   	public function PublisherModelLocator() 
	   	{
	   		if ( instance != null )
					throw new CairngormError(
					   CairngormMessageCodes.SINGLETON_EXCEPTION, "PublisherModelLocator" );
					
				initialize();
	   	}
	   	
	
		public static function getInstance() : PublisherModelLocator
		{
			if ( instance == null )
				instance = new PublisherModelLocator();
				
			return instance;
	   	}
	   	  	
	   	private function initialize() : void
	   	{
	   		pubController = new PublisherController();
	   	}
	   	
	}
}