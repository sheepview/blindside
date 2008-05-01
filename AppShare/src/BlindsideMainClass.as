import mx.containers.Panel;
import flash.events.Event;
import mx.controls.Alert;
	
import org.blindsideproject.core.apps.conference.model.*;
import org.blindsideproject.core.util.log.ILogger;
import org.blindsideproject.core.util.log.LoggerModelLocator;
import org.blindsideproject.core.apps.conference.controller.commands.JoinCommand;
import org.blindsideproject.core.apps.conference.controller.events.ConferenceEvents;
import org.blindsideproject.core.apps.conference.controller.events.DisconnectedEvent;
import com.adobe.cairngorm.control.CairngormEventDispatcher;
import com.adobe.cairngorm.control.CairngormEvent;
import org.blindsideproject.core.apps.conference.controller.commands.LeaveCommand;
import org.blindsideproject.core.apps.presentation.PresentationApplication;
import org.blindsideproject.meetme.model.MeetMeModelLocator;
import org.blindsideproject.main.*;

import mx.core.Application;

import flash.display.Stage;
import org.blindsideproject.core.apps.chat.ChatApplication;
import mx.utils.StringUtil;
		
	private var model : ConferenceModelLocator = ConferenceModelLocator.getInstance();
	private var dispatcher : CairngormEventDispatcher = model.dispatcher;
	private var log : ILogger = LoggerModelLocator.getInstance().log;
	private var meetMeModel : MeetMeModelLocator = MeetMeModelLocator.getInstance();
//	private var main : BlindsideAppLocator = BlindsideAppLocator.getInstance();
		
	private var presentationApp : PresentationApplication;
			
	private var host : String = "localhost";
//	private var host : String = "present.sce.carleton.ca";
	
	public function conferenceMainClassInit() : void {
//		host = mx.core.Application.application.parameters.host;
			
//		host = mx.core.Application.application.parameters.host;
		log.debug("Passed in var = [" + mx.core.Application.application.parameters.host + "]");
		log.debug("Host URL = [" + mx.core.Application.application.url + "]");
		log.debug("App URL = [" + mx.core.Application.application.url.substr(0,4) + "]");
	}
			
	public function doLogin(name : String, room : String, password : String):void
	{
		//remove extra whitespaces in case use uses cut 'n paste
		var command : JoinCommand = new JoinCommand(StringUtil.trim(name), StringUtil.trim(password),
				StringUtil.trim(room), StringUtil.trim(host));			
		command.dispatch();	

		dispatcher.addEventListener(ConferenceEvents.CONNECTED_EVENT, onConnectedEvent);
		dispatcher.addEventListener(ConferenceEvents.DISCONNECTED_EVENT, onDisconnectedEvent);	
	}
		
	public function doLogout():void
	{
		log.debug("Logging out");
			
		var command : LeaveCommand = new LeaveCommand();
		command.dispatch();				
	}
				
	private function onConnectedEvent(event : CairngormEvent):void
	{
		if (event.type != ConferenceEvents.CONNECTED_EVENT)
			return;			

		initializeConferenceRoom();
		conferenceViewStack.selectedChild=conferenceView;	
	}
				
	private function onDisconnectedEvent(e : CairngormEvent):void
	{
		var event : DisconnectedEvent = DisconnectedEvent(e);
			
		if (event.type != ConferenceEvents.DISCONNECTED_EVENT)
			return;
		
		if (BlindsideAppLocator.getInstance().presentation != null) 
			BlindsideAppLocator.getInstance().presentation.leave();
		if (BlindsideAppLocator.getInstance().chat != null)
			BlindsideAppLocator.getInstance().chat.leave();
				
		//chatModel.chat.chatDelegate.close();
		//meetMeModel.meetMeRoom.getConnection().close();
		
		conferenceViewStack.selectedChild=loginView;		
	}		

	private function initializeConferenceRoom() : void
	{	
		log.debug("Logged in. Initializing conference.");
	
	   	meetMeModel.setupMeetMeRoom();	   		
		meetMeModel.meetMeRoom.setUri("rtmp://" + host + "/astmeetme/" + model.conference.room);	

		BlindsideAppLocator.getInstance().presentation 
			= new PresentationApplication(model.conference.me.userid, model.conference.room,
					"rtmp://" + host, "http://" + host + ":8080");
		BlindsideAppLocator.getInstance().presentation.join();
		
		BlindsideAppLocator.getInstance().chat 
				= new ChatApplication(model.conference.me.userid, model.conference.room, "rtmp://" + host);
		BlindsideAppLocator.getInstance().chat.join();		
				
	
	}
	