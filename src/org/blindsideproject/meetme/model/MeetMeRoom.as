package org.blindsideproject.meetme.model
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.blindsideproject.meetme.business.NetConnectionDelegate;

	import flash.events.Event;
	import mx.collections.ArrayCollection;
 	
	public class MeetMeRoom
	{
		// Dispatcher to send events to UIs
		public var dispatcher : CairngormEventDispatcher = CairngormEventDispatcher.getInstance();
					
		[Bindable]
		public var isConnected : Boolean;
		
		[Bindable]
		public var dpParticipants : ArrayCollection;
		
		private var room : String;
		private var uri : String;
				
		private var netConnection : NetConnectionDelegate;
		
		[Bindable]
		public var userRole : String;
	
		public function MeetMeRoom()
		{
							
		}
		
		public function setUri(uri : String) : void
		{
			this.uri = uri;
		}
		
		public function getUri() : String
		{
			return uri;
		}
		
		public function setConnectionDelegate(connection : NetConnectionDelegate) : void
		{
			netConnection = connection;
		}
		
		public function getConnection() : NetConnectionDelegate {
			return netConnection;
		}

		public function sendConnectedEvent():void
		{
//			var event : CairngormEvent = new CairngormEvent(ConferenceEvents.CONNECTED_EVENT);
//			dispatcher.dispatchEvent(event);
		}

		
		public function sendDisconnectedEvent(reason : uint, message : String):void
		{
//			var event : DisconnectedEvent = new DisconnectedEvent(ConferenceEvents.DISCONNECTED_EVENT,
//												reason, message);
//			dispatcher.dispatchEvent(event);
		}
	}
}