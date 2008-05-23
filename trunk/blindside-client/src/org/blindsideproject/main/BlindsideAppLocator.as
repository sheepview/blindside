package org.blindsideproject.main
{
	import com.adobe.cairngorm.CairngormError;
	import com.adobe.cairngorm.CairngormMessageCodes;
	import com.adobe.cairngorm.model.IModelLocator;
	
	import org.blindsideproject.core.apps.chat.ChatApplication;
	import org.blindsideproject.core.apps.conference.ConferenceApplication;
	import org.blindsideproject.core.apps.presentation.model.PresentationFacade;
	import org.red5.samples.publisher.PublisherApplication;
	
	public class BlindsideAppLocator implements IModelLocator
	{
		public static const ID : String = "BlindsideAppLocator";
			
		private static var instance : BlindsideAppLocator;
				
		public var presentationFacade :PresentationFacade;
		public var chatApp : ChatApplication;
		public var publisherApp : PublisherApplication;
		public var conferenceApp : ConferenceApplication;
		
		public function BlindsideAppLocator() : void
		{
			if ( instance != null ) {
					throw new CairngormError(
					   CairngormMessageCodes.SINGLETON_EXCEPTION, "BlindsideAppLocator" );
			}
			
			initialize();		
		}

		public static function getInstance() : BlindsideAppLocator
		{
			if ( instance == null )
				instance = new BlindsideAppLocator();
				
			return instance;
	   	}	

	   	private function initialize() : void
	   	{		

	   	}	   
	}
}