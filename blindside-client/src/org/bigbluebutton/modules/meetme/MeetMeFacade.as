package org.bigbluebutton.modules.meetme
{
	import com.adobe.cairngorm.*;
	
	import org.bigbluebutton.modules.meetme.control.StartupMeetMeCommand;
	import org.bigbluebutton.modules.meetme.model.MeetMeRoom;
	import org.bigbluebutton.modules.meetme.view.ListenersWindow;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
		
	[Bindable]
	public class MeetMeFacade extends Facade implements IFacade
	{
		public static const ID : String = "VoiceConferenceModelLocator";
		public static const STARTUP:String = "StartupVoiceConference";
		
		//EVENTS
		public static const MUTE_UNMUTE_USER_COMMAND : String = "MEETME_MUTE_UNMUTE_USER";
		public static const EJECT_USER_COMMAND : String = "MEETME_EJECT_USER";
		public static const MUTE_ALL_USERS_COMMAND : String = "MEETME_MUTE_ALL_USER";
		public static const USER_JOIN_EVENT:String = "User Join Event";
		public static const MUTE_EVENT:String = "mute event";
		
		private static var instance : MeetMeFacade;
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		
		public var meetMeRoom:MeetMeRoom;
				
		public function MeetMeFacade()
		{
			super(ID);		
		}
		
		public static function getInstance() : MeetMeFacade
		{
			if (instanceMap[ID] == null) instanceMap[ID] = new MeetMeFacade();
			return instanceMap[ID] as MeetMeFacade;
	   	}		
	   	
	   	override protected function initializeController():void{
	   		super.initializeController();
	   		registerCommand(STARTUP, StartupMeetMeCommand);
	   	}
	   	
	   	public function startup(app:ListenersWindow):void{
	   		meetMeRoom = new MeetMeRoom();
	   		sendNotification(STARTUP, app);
	   		//meetMeRoom.getConnection().connect();
	   	}
	   	
	   	// Had to create this to prevent stack overflow when done during initialize	 
	   	public function setupMeetMeRoom(userRole : String) : void
	   	{
			meetMeRoom.userRole = userRole;
	   	}  	

		public function connectToMeetMe() : void
	   	{
			meetMeRoom.getConnection().connect();		
	   	}
	   		   	
	   	public function getMeetMeRoom() : MeetMeRoom
	   	{
	   		return meetMeRoom;
	   	}
	}
}