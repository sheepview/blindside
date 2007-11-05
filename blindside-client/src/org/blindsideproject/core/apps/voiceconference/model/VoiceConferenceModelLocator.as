package org.blindsideproject.core.apps.voiceconference.model
{
	import com.adobe.cairngorm.model.IModelLocator;
	import org.blindsideproject.core.util.log.*;

	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.*
	import com.adobe.cairngorm.control.FrontController;
	import org.blindsideproject.core.apps.voiceconference.business.SOVoiceConferenceDelegate;
	import org.blindsideproject.core.apps.voiceconference.controller.VoiceConferenceController;

	
	public class VoiceConferenceModelLocator implements IModelLocator
	{
		public static const ID : String = "VoiceConferenceModelLocator";
	
		private var _controller : FrontController = null;
		
		private static var instance : VoiceConferenceModelLocator;
		
		private var _conferenceDelegate : SOVoiceConferenceDelegate = null;	
			
		[Bindable]
		public var conference : VoiceConference = new VoiceConference();
		
		public function VoiceConferenceModelLocator() : void
		{
			if ( instance != null ) {
					throw new CairngormError(
					   CairngormMessageCodes.SINGLETON_EXCEPTION, ID );
			}
			
			initialize();		
		}

		public static function getInstance() : VoiceConferenceModelLocator
		{
			if ( instance == null )
				instance = new VoiceConferenceModelLocator();
				
			return instance;
	   	}	

	   	private function initialize() : void
	   	{		
	   		_controller = new VoiceConferenceController();
	   	}	   	
  		   		   	
	   	public function get conferenceDelegate() : SOVoiceConferenceDelegate
	   	{
	   		if (_conferenceDelegate == null) {
	   			_conferenceDelegate = new SOVoiceConferenceDelegate(conference);
	   		}
	   		
	   		return _conferenceDelegate;
	   	}
	}
}