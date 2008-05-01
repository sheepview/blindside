import mx.containers.Panel;
import flash.events.Event;
	
import org.blindsideproject.conference.model.*;
import org.blindsideproject.util.components.logger.model.Logger;
import org.blindsideproject.conference.events.ConferenceJoinEvent;
import org.blindsideproject.conference.control.ConferenceEvents;
import org.blindsideproject.conference.events.DisconnectedEvent;
import org.blindsideproject.conference.control.ConferenceController;
import com.adobe.cairngorm.control.CairngormEventDispatcher;
import com.adobe.cairngorm.control.CairngormEvent;
import org.blindsideproject.conference.events.ConferenceLeaveEvent;
import org.blindsideproject.chat.model.*;
import org.blindsideproject.conference.vo.*;
import org.blindsideproject.meetme.model.MeetMeModelLocator;
import org.blindsideproject.presentation.model.PresentationModelLocator;
import org.blindsideproject.presentation.model.PresentationModelLocator;
import mx.core.Application;

import flash.display.Stage;
		
	private var model : ConferenceModelLocator = ConferenceModelLocator.getInstance();
	private var dispatcher : CairngormEventDispatcher = model.getDispatcher();
	private var log : Logger = model.getLogger();
	
	private var chatModel : ChatModelLocator = ChatModelLocator.getInstance();
	private var meetMeModel : MeetMeModelLocator = MeetMeModelLocator.getInstance();
	private var presentationModel : PresentationModelLocator = PresentationModelLocator.getInstance();
		
	[Bindable]
	protected var conference : Conference;
	
	private var host : String = "present.sce.carleton.ca";
	
	private var uploadHost : String = "http://present.sce.carleton.ca/";
	//private var uploadHost : String = "http://" + host + ":8080/";
			
	public function conferenceMainClassInit() : void {
		conference = new Conference();	
//		host = mx.core.Application.application.parameters.host;
			
//		host = mx.core.Application.application.parameters.host;
		log.debug("Passed in var = [" + mx.core.Application.application.parameters.host + "]");
	}
		
	public function getConference() : Conference
	{
		return conference;
	}		

	public function doLogin(name : String, room : String, password : String):void
	{
		log.debug("Login : " + name);
			
		conference.setUsername(name);
		conference.setRoom(room);
		
		//134.117.58.58
		// This should be passed as flashvars
		conference.setUri("rtmp://" + host + "/fitcDemo/" + room);
				
		// Let's hardcode authentication here for now
		if ( ("modpass" != password) && ("viewpass" != password)) {
			returnMessage.text = "Wrong password. Please try again.";
			return;
		} 	

		conference.setPassword(password);
			
		// Successfully "logged-in"
		returnMessage.text = "";
		
		// Setup the user's role
		conference.userRole = Role.PARTICIPANT;		
		if ("modpass" == password) conference.userRole = Role.MODERATOR;
		
		var event : ConferenceJoinEvent = new ConferenceJoinEvent(conference);
			
		event.dispatch();	

		dispatcher.addEventListener(ConferenceEvents.CONNECTED_EVENT, onConnectedEvent);
		dispatcher.addEventListener(ConferenceEvents.DISCONNECTED_EVENT, onDisconnectedEvent);	
	}
		
	public function doLogout():void
	{
		log.debug("Logging out");
			
		var event : ConferenceLeaveEvent = new ConferenceLeaveEvent(conference);
		event.dispatch();
				
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
				
		log.debug("reason = " + event.getMessage());
		
		//chatModel.chat.chatDelegate.close();
		//meetMeModel.meetMeRoom.getConnection().close();
		
		conferenceViewStack.selectedChild=loginView;		
	}		

	private function initializeConferenceRoom() : void
	{	
	//	chatModel.setupChatRoom();		
	//	chatModel.chat.uri = "rtmp://" + host + "/fitcDemo/" + conference.getRoom() + "/chat";	
	   	meetMeModel.setupMeetMeRoom();	   		
		meetMeModel.meetMeRoom.setUri("rtmp://" + host + "/astmeetme/" + conference.getRoom());	
		presentationModel.setupPresentation();
		presentationModel.presentation.uri = "rtmp://" + host + "/SOSample/" + conference.getRoom();
		presentationModel.presentation.setRoom(conference.getRoom());
		presentationModel.presentation.setFileUploadHost(uploadHost);
		presentationModel.presentation.setFileUploadUri("fileupload/file/fileUpload");
		presentationModel.presentation.setSlideDisplayUri("fileupload/file/xmlslides?room=" + conference.getRoom());
		presentationModel.presentation.setRole(conference.getRole());	
	}
	