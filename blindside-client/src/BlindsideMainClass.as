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

import mx.binding.utils.BindingUtils;
import mx.core.Application;

import flash.display.Stage;
import org.blindsideproject.core.apps.chat.ChatApplication;
import mx.utils.StringUtil;
import mx.managers.PopUpManager;
import org.red5.samples.publisher.PublisherApplication;
import org.blindsideproject.core.apps.conference.ConferenceApplication;
	

			 
	private var joinWindow : JoinWindow;
	
	private var model : ConferenceModelLocator = ConferenceModelLocator.getInstance();
	private var dispatcher : CairngormEventDispatcher = CairngormEventDispatcher.getInstance();
	private var log : ILogger = LoggerModelLocator.getInstance().log;
	private var meetMeModel : MeetMeModelLocator = MeetMeModelLocator.getInstance();
	private var mainApp : BlindsideAppLocator = BlindsideAppLocator.getInstance();
		
	private var presentationApp : PresentationApplication;
		
//	private var host : String = "134.117.58.98";		
	private var host : String = "localhost";
//	private var host : String = "present.sce.carleton.ca";
	
	public function conferenceMainClassInit() : void {
//		host = mx.core.Application.application.parameters.host;
			
//		host = mx.core.Application.application.parameters.host;
		log.debug("Passed in var = [" + mx.core.Application.application.parameters.host + "]");
		log.debug("Host URL = [" + mx.core.Application.application.url + "]");
		log.debug("App URL = [" + mx.core.Application.application.url.substr(0,4) + "]");
		
		BlindsideAppLocator.getInstance().conferenceApp = new ConferenceApplication(host);
		
		openJoinWindow();
		
		BindingUtils.bindSetter(handleConnected, mainApp.conferenceApp.conference, "connected");
	}

	public function handleConnected(connected : Boolean) : void
	{
		if (connected) {
			initializeConferenceRoom();
			closeJoinWindow();

			toolbar.visible = true;
			confScreen.visible = true;
		} else {
			if (mainApp.presentationApp != null) mainApp.presentationApp.leave();
			if (mainApp.chatApp != null) mainApp.chatApp.leave();
			if (mainApp.publisherApp != null) mainApp.publisherApp.disconnect();

			openJoinWindow();
			toolbar.visible = false;
			confScreen.visible = false;
		}
	}
		
	private function openJoinWindow() : void
	{
		if (joinWindow == null) {
         	joinWindow = JoinWindow(PopUpManager.createPopUp( this, JoinWindow, false));
         	PopUpManager.centerPopUp(joinWindow);
         	log.debug("Pop-up JoinWindow");
  		} else {
  			log.debug("Did not Pop-up JoinWindow");
  		} 
    }	
    
    private function closeJoinWindow() : void
    {
    	if (joinWindow != null) {
    		PopUpManager.removePopUp(joinWindow);
    		joinWindow = null;
    	}
    }

	private function initializeConferenceRoom() : void
	{	
		log.debug("Logged in. Initializing conference.");
	
	   	meetMeModel.setupMeetMeRoom(model.conference.me.role);	   		
		meetMeModel.meetMeRoom.setUri("rtmp://" + host + "/astmeetme/" + model.conference.room);	
		meetMeModel.connectToMeetMe();
		
		mainApp.presentationApp 
			= new PresentationApplication(model.conference.me.userid, model.conference.room,
					"rtmp://" + host, "http://" + host + ":8080");
		mainApp.presentationApp.join();
		
		mainApp.chatApp 
				= new ChatApplication(model.conference.me.userid, model.conference.room, "rtmp://" + host);
		mainApp.chatApp.join();		
				
		mainApp.publisherApp = new PublisherApplication();
		mainApp.publisherApp.setupDevices();
		mainApp.publisherApp.setupConnection();
		
		var streamName : String = model.conference.me.userid.toString() + 
				"_stream" + String( Math.floor( new Date().getTime() ) );
		
		mainApp.publisherApp.setupStream(streamName);
		mainApp.publisherApp.connect("rtmp://" + host + "/oflaDemo/" + model.conference.room);

	}
	