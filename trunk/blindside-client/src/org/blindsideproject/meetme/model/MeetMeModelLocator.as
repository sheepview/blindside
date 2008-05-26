package org.blindsideproject.meetme.model
{
	import com.adobe.cairngorm.*;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
	import org.blindsideproject.meetme.business.NetConnectionDelegate;
	import org.blindsideproject.meetme.control.StartupMeetMeCommand;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
		
	[Bindable]
	public class MeetMeModelLocator extends Facade implements IFacade
	{
		public static const ID : String = "VoiceConferenceModelLocator";
		public static const STARTUP:String = "StartupVoiceConference";
		
		//EVENTS
		public static const MUTE_UNMUTE_USER_COMMAND : String = "MEETME_MUTE_UNMUTE_USER";
		public static const EJECT_USER_COMMAND : String = "MEETME_EJECT_USER";
		public static const MUTE_ALL_USERS_COMMAND : String = "MEETME_MUTE_ALL_USER";
		public static const USER_JOIN_EVENT:String = "User Join Event";
		public static const MUTE_EVENT:String = "mute event";
		
		private static var instance : MeetMeModelLocator;
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		
		// Dispatcher to send events to UIs
		private var dispatcher : CairngormEventDispatcher = CairngormEventDispatcher.getInstance();
		
		public var meetMeRoom : MeetMeRoom;
		
		private var conn : NetConnectionDelegate;
				
		public function MeetMeModelLocator()
		{
			super(ID);		
		}
		
		public static function getInstance() : MeetMeModelLocator
		{
			if (instanceMap[ID] == null) instanceMap[ID] = new MeetMeModelLocator();
			return instanceMap[ID] as MeetMeModelLocator;
	   	}		
	   	
	   	override protected function initializeController():void{
	   		super.initializeController();
	   		registerCommand(STARTUP, StartupMeetMeCommand);
	   	}
		
	   	private function initialize() : void
	   	{		
			meetMeRoom = new MeetMeRoom();
	   	}	
	   	
	   	// Had to create this to prevent stack overflow when done during initialize	 
	   	public function setupMeetMeRoom(userRole : String) : void
	   	{
			
			meetMeRoom.userRole = userRole;
			conn = new NetConnectionDelegate(meetMeRoom);	 		
	   	}  	

		public function connectToMeetMe() : void
	   	{
			meetMeRoom.getConnection().connect();		
	   	}
	   		   	
	   	public function getMeetMeRoom() : MeetMeRoom
	   	{
	   		return meetMeRoom;
	   	}
	   		   	
	   	public function getDispatcher() : CairngormEventDispatcher
	   	{
	   		return dispatcher;
	   	}
	}
}