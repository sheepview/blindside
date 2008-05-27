package org.blindsideproject.meetme.model
{
	import mx.collections.ArrayCollection;
	
	import org.blindsideproject.meetme.business.NetConnectionDelegate;
 	
	public class MeetMeRoom
	{
					
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
			return MeetMeFacade.getInstance().retrieveProxy(NetConnectionDelegate.NAME) as NetConnectionDelegate;
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