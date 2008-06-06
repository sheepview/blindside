package org.bigbluebutton.modules.voiceconference
{
	import com.adobe.cairngorm.*;
	
	import flash.net.NetConnection;
	
	import org.bigbluebutton.modules.voiceconference.control.StartupVoiceConfCommand;
	import org.bigbluebutton.modules.voiceconference.model.VoiceConferenceRoom;
	import org.bigbluebutton.modules.voiceconference.model.business.NetConnectionDelegate;
	import org.bigbluebutton.modules.voiceconference.view.ListenersWindow;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerFacade;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
		
	/**
	 * The  MeetMeFacade is the main Facade of the MeetMe module. It extends the Facade class of the PureMVC
	 * framework
	 * @author Richard Alam
	 * 
	 */	
	public class VoiceConferenceFacade extends Facade implements IFacade
	{
		public static const ID : String = "VoiceConferenceFacade";
		public static const STARTUP:String = "StartupVoiceConference";
		
		//EVENTS
		public static const MUTE_UNMUTE_USER_COMMAND : String = "MEETME_MUTE_UNMUTE_USER";
		public static const EJECT_USER_COMMAND : String = "MEETME_EJECT_USER";
		public static const MUTE_ALL_USERS_COMMAND : String = "MEETME_MUTE_ALL_USER";
		public static const USER_JOIN_EVENT:String = "User Join Event";
		public static const MUTE_EVENT:String = "mute event";
		
		public var meetMeRoom:VoiceConferenceRoom;
				
		/**
		 * The default constructor. Should NEVER be called directly, as this class is a singleton.
		 * Instead, use the getInstance() method 
		 * 
		 */		
		public function VoiceConferenceFacade()
		{
			super(ID);		
		}
		
		/**
		 *  
		 * @return The instance of MeetMeFacade singleton class
		 * 
		 */		
		public static function getInstance() : VoiceConferenceFacade
		{
			if (instanceMap[ID] == null) instanceMap[ID] = new VoiceConferenceFacade();
			return instanceMap[ID] as VoiceConferenceFacade;
	   	}		
	   	
	   	/**
	   	 * Initializes the controller part of this MVC module 
	   	 * 
	   	 */	   	
	   	override protected function initializeController():void{
	   		super.initializeController();
	   		registerCommand(STARTUP, StartupVoiceConfCommand);
	   	}
	   	
	   	/**
	   	 * Sends out a notification to start the command which initiates the mediators and the proxies 
	   	 * @param app
	   	 * 
	   	 */	   	
	   	public function startup(app:ListenersWindow, uri:String):void{
	   		meetMeRoom = new VoiceConferenceRoom(uri);
	   		sendNotification(STARTUP, app);
	   		//meetMeRoom.getConnection().connect();
	   	}
	   	
	   	/**
	   	 *  Richard: Had to create this to prevent stack overflow when done during initialize	 
	   	 * @param userRole
	   	 * 
	   	 */	   	
	   	public function setupMeetMeRoom(userRole : String) : void
	   	{
			meetMeRoom.userRole = userRole;
	   	}  	

		/**
		 * Initializes the connection to the server 
		 * 
		 */
		public function connectToMeetMe() : void
	   	{
	   		var netProxy:NetConnectionDelegate = retrieveProxy(NetConnectionDelegate.NAME) as NetConnectionDelegate;
			netProxy.connect(new NetConnection());		
	   	}
	   		   	
	   	/**
	   	 * 
	   	 * @return The MeetMeRoom of the MeetMe module
	   	 * 
	   	 */	   		   	
	   	public function getMeetMeRoom():VoiceConferenceRoom
	   	{
	   		return meetMeRoom;
	   	}
	}
}