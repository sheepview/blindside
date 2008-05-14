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
	
import flexmdi.effects.effectsLib.MDILinearEffects;
import flexmdi.effects.MDIEffectsDescriptorBase;
import mx.controls.TextArea;
import flexmdi.events.MDIWindowEvent;
import flexmdi.effects.effectsLib.MDIVistaEffects;
import flexmdi.events.MDIManagerEvent;
			
import mx.controls.Alert;
import mx.events.CloseEvent;
import org.blindsideproject.views.chat.ChatWindow;
import org.blindsideproject.meetme.view.ListenersWindow;
import org.blindsideproject.views.presentation.PresentationWindow;
import org.blindsideproject.views.conference.ViewersWindow;
import org.blindsideproject.views.phone.PhoneWindow;
import flexmdi.containers.MDIWindow;
import org.blindsideproject.views.control.events.ViewEvents;
import org.blindsideproject.views.control.events.OpenWindowEvent;
import org.blindsideproject.views.log.LogWindow;
import org.red5.samples.publisher.MediaType;
import org.red5.samples.publisher.vo.IMedia;
import org.blindsideproject.views.presentation.PresentationPanel;
			
private var eventMonitor:TextArea;
private var queuedEvent:MDIManagerEvent;
private var effectsList:Array;
						 
	private var joinWindow : JoinWindow;
	private var chatWindow : ChatWindow;
	private var listenersWindow : ListenersWindow;
	private var presentationWindow : PresentationWindow;
	private var presentationPanel : PresentationPanel;
	private var viewersWindow : ViewersWindow;
	private var logWindow : LogWindow;

	
	private var model : ConferenceModelLocator = ConferenceModelLocator.getInstance();
	private var dispatcher : CairngormEventDispatcher = CairngormEventDispatcher.getInstance();
	private var log : ILogger = LoggerModelLocator.getInstance().log;
	private var meetMeModel : MeetMeModelLocator = MeetMeModelLocator.getInstance();
	private var mainApp : BlindsideAppLocator = BlindsideAppLocator.getInstance();
		
	private var presentationApp : PresentationApplication;
		
	private var red5Host : String = "localhost";		
	private var presentationHost : String = "localhost";
	private var asteriskHost : String;
	
	public function conferenceMainClassInit() : void {
		red5Host = mx.core.Application.application.parameters.red5Host;			
		presentationHost = mx.core.Application.application.parameters.presentationHost;
		asteriskHost = mx.core.Application.application.parameters.asteriskHost;
		
		log.debug("red5Host = [" + red5Host + "]");
		log.debug("presentationHost = [" + presentationHost + "]");
		log.debug("asteriskHost = [" + asteriskHost + "]");
		
		mdiCanvas.effectsLib = flexmdi.effects.effectsLib.MDIVistaEffects;
		
		BlindsideAppLocator.getInstance().conferenceApp = new ConferenceApplication(red5Host);
		
		openJoinWindow();
		
		BindingUtils.bindSetter(handleConnected, mainApp.conferenceApp.conference, "connected");
		
		dispatcher.addEventListener(ViewEvents.OPEN_NEW_WINDOW_EVENT, onOpenWindow);
	}

	public function handleConnected(connected : Boolean) : void
	{
		if (connected) {
			initializeConferenceRoom();
			closeJoinWindow();

			toolbar.visible = true;
		} else {
			if (mainApp.presentationApp != null) mainApp.presentationApp.leave();
			if (mainApp.chatApp != null) mainApp.chatApp.leave();
			if (mainApp.publisherApp != null) mainApp.publisherApp.disconnect();

			openJoinWindow();
			toolbar.visible = false;
			if (presentationPanel != null) {
				presentationPanel.visible = false;
				presentationPanel = null;
			}
			mdiCanvas.windowManager.removeAll();
		}
	}
		
	private function openJoinWindow() : void
	{
		if (joinWindow == null) {
         	joinWindow = JoinWindow(PopUpManager.createPopUp( this, JoinWindow, false));
         	PopUpManager.centerPopUp(joinWindow);
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
		meetMeModel.meetMeRoom.setUri("rtmp://" + red5Host + "/astmeetme/" + model.conference.room);	
		meetMeModel.connectToMeetMe();
		
		mainApp.presentationApp 
			= new PresentationApplication(model.conference.me.userid, model.conference.room,
					"rtmp://" + red5Host, "http://" + presentationHost);
		mainApp.presentationApp.join();
		
		mainApp.chatApp 
				= new ChatApplication(model.conference.me.userid, model.conference.room, "rtmp://" + red5Host);
		mainApp.chatApp.join();		
				
		mainApp.publisherApp = new PublisherApplication(); 
		mainApp.publisherApp.setupDevices();
		mainApp.publisherApp.setupConnection();
		
		mainApp.publisherApp.connect("rtmp://" + red5Host + "/oflaDemo/" + model.conference.room);
		
		chatWindow = new ChatWindow();
		chatWindow.width = 300;
		chatWindow.height = 350;
		chatWindow.title = "Group Chat";
		chatWindow.showCloseButton = false;
		mdiCanvas.windowManager.add(chatWindow);
		mdiCanvas.windowManager.absPos(chatWindow, 800, 10);
		
		// Determine if we show the phone button on the toolbar or not
		if (asteriskHost == null) {
			toolbar.phoneBtn.visible = false;
		} else {
			toolbar.phoneBtn.visible = true;
			toolbar.asteriskHost = asteriskHost;
		}
		
		listenersWindow = new ListenersWindow();
		listenersWindow.width = 210;
		listenersWindow.height = 200;
		listenersWindow.title = "Listeners";
		listenersWindow.showCloseButton = false;
		mdiCanvas.windowManager.add(listenersWindow);
		mdiCanvas.windowManager.absPos(listenersWindow, 20, 250);
			
		presentationWindow = new PresentationWindow();
		presentationWindow.width = 464;
		presentationWindow.height = 378;
		presentationWindow.title = "Presentation";
		presentationWindow.showCloseButton = false;
		mdiCanvas.windowManager.add(presentationWindow);
		mdiCanvas.windowManager.absPos(presentationWindow, 240, 20);

/*
		presentationPanel = new PresentationPanel();
		presentationPanel.width = 700;
		presentationPanel.height = 500;
		presentationPanel.title = "Presentation";
		presentationPanel.x = 240;
		presentationPanel.y = 20;
		mdiCanvas.addChild(presentationPanel);
*/		
		viewersWindow = new ViewersWindow();
		viewersWindow.width = 210;
		viewersWindow.height = 220;
		viewersWindow.title = "Viewers";
		viewersWindow.showCloseButton = false;
		mdiCanvas.windowManager.add(viewersWindow);		
		mdiCanvas.windowManager.absPos(viewersWindow, 20, 20);
	}
	
	
	private function popupLogWindow() : void
	{
		if (logWindow != null) return;
		
		logWindow = new LogWindow();
		logWindow.width = 600;
		logWindow.height = 280;
		logWindow.title = "Log";
		logWindow.showCloseButton = true;
		mdiCanvas.windowManager.add(logWindow);	
		mdiCanvas.windowManager.absPos(logWindow, 700, 500);	
	}
	
private function onOpenWindow(event : CairngormEvent):void
{
	var winEvent : OpenWindowEvent = OpenWindowEvent(event);
	
	mdiCanvas.windowManager.add(winEvent.window);
}
			
