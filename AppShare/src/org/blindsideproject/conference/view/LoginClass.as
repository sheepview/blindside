package org.blindsideproject.conference.view
{
	import mx.containers.Box;
	import org.blindsideproject.conference.model.*;
	import org.blindsideproject.util.components.logger.model.Logger;
	import org.blindsideproject.conference.events.ConferenceJoinEvent;
	import org.blindsideproject.conference.control.ConferenceEvents;
	import flash.events.Event;
	import org.blindsideproject.conference.events.DisconnectedEvent;
	import org.blindsideproject.conference.control.ConferenceController;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.conference.events.ConferenceLeaveEvent;
	
	public class LoginClass extends Box
	{
		private var model : ConferenceModelLocator = ConferenceModelLocator.getInstance();
		private var dispatcher : CairngormEventDispatcher = model.getDispatcher();
		private var log : Logger = model.getLogger();
		
		public var conference : Conference;

		[Bindable]
		public var btnLabel : String = "Login";
		
		[Bindable]
		public var notJoined : Boolean = true;
				
		public function doLogin(name : String):void
		{
			log.debug("Login : " + name);
			
			conference.setUsername(name);
			
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
				
			btnLabel = "Logout";
			notJoined = false;
			log.debug("Changing btnLabel to " + btnLabel);
		}
				
		private function onDisconnectedEvent(e : CairngormEvent):void
		{
			var event : DisconnectedEvent = DisconnectedEvent(e);
			
			if (event.type != ConferenceEvents.DISCONNECTED_EVENT)
				return;
				
			notJoined = true;
			btnLabel = "Login";
			log.debug("Changing btnLabel to " + btnLabel);	
			log.debug("reason = " + event.getMessage());		
		}
	}
}