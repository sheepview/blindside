package org.blindsideproject.core.apps.voiceconference.model
{
	import com.adobe.cairngorm.*;
	import com.adobe.cairngorm.control.FrontController;
	
	import org.blindsideproject.core.apps.voiceconference.business.SOVoiceConferenceDelegate;
	import org.blindsideproject.core.apps.voiceconference.controller.VoiceConferenceController;
	import org.blindsideproject.core.util.log.*;
	import org.blindsideproject.meetme.view.ListenersWindow;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;

	
	public class VoiceConferenceModelLocator extends Facade implements IFacade
	{
		public static const ID : String = "VoiceConferenceModelLocator";
		public static const STARTUP:String = "StartupVoiceConference";
		
		//EVENTS
		public static const JOIN_COMMAND : String = "VOICE_CONFERENCE_JOIN_COMMAND";
		public static const LEAVE_COMMAND : String = "VOICE_CONFERENCE_LEAVE_COMMAND";
		public static const EJECT_USER_COMMAND : String = "VOICE_CONFERENCE_EJECT_USER_COMMAND";
		public static const MUTE_USER_COMMAND : String = "VOICE_CONFERENCE_MUTE_USER_COMMAND";	
		public static const MUTE_ALL_USERS_COMMAND : String = "VOICE_CONFERENCE_MUTE_ALL_USERS_COMMAND";
	
		private var _controller : FrontController = null;
		
		private static var instance : VoiceConferenceModelLocator;
		
		private var _conferenceDelegate : SOVoiceConferenceDelegate = null;	
			
		[Bindable]
		public var conference : VoiceConference = new VoiceConference();
		
		public function VoiceConferenceModelLocator() : void
		{
			super(ID);		
		}

		public static function getInstance() : VoiceConferenceModelLocator
		{
			if (instanceMap[ID] == null) instanceMap[ID] = new VoiceConferenceModelLocator();
			return instanceMap[ID] as VoiceConferenceModelLocator;
	   	}
	   	
	   	override public function initializeController():void{
	   		super.initializeController();
	   		registerCommand(STARTUP, StartupCommand);
	   	}	
	   	
	   	public function startup(app:ListenersWindow):void{
	   		sendNotification(STARTUP, app);
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