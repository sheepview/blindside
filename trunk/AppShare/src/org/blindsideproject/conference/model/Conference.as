package org.blindsideproject.conference.model
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.blindsideproject.conference.control.ConferenceEvents;
	import org.blindsideproject.conference.events.DisconnectedEvent;
	import org.blindsideproject.conference.view.general.Images;
	import org.blindsideproject.conference.business.NetConnectionDelegate;

	import flash.events.Event;
	import mx.collections.ArrayCollection;
	import org.blindsideproject.conference.vo.Role;
 	
	public class Conference
	{
		// Dispatcher to send events to UIs
		public var dispatcher : CairngormEventDispatcher = CairngormEventDispatcher.getInstance();
				
		[Bindable]
		public var images:Images;	
		
		[Bindable]
		public var isConnected : Boolean;
		
		[Bindable]
		public var userRole : uint = Role.PARTICIPANT;
		
		[Bindable]
		public var dpParticipants : ArrayCollection;
		
		private var room : String;
		private var uri : String;
		
		[Bindable]
		public var username : String = "Unknown";
		
		private var userStatus : String = "confused";
		
		private var password : String;
		
		private var netConnection : NetConnectionDelegate;
				
	
		public function Conference()
		{
			images = new Images();								
		}
		
		public function setUri(uri : String) : void
		{
			this.uri = uri;
		}
		
		public function getUri() : String
		{
			return uri;
		}
		
		public function setRoom(room : String) : void
		{
			this.room = room;
		}
		
		public function getRoom() : String
		{
			return room;
		}
		
		public function setUsername(username : String) : void
		{
			this.username = username;
		}
		
		public function getUsername() : String
		{
			return username;
		}
		
		public function setPassword(password : String = "") : void
		{
			this.password = password;
		}
		
		public function getPassword() : String
		{
			return password;
		}
		public function setConnectionDelegate(connection : NetConnectionDelegate) : void
		{
			netConnection = connection;
		}
		
		public function getConnection() : NetConnectionDelegate {
			return netConnection;
		}

		public function setUserStatus(userStatus : String) : void
		{
			this.userStatus = userStatus;
		}
						
		public function getUserStatus() : String
		{
			return userStatus;
		}
		
		public function setRole(role : uint) : void  {
			this.userRole = role;
		}
		
		public function getRole() : uint
		{
			return userRole;
		}
		
		public function sendConnectedEvent():void
		{
			var event : CairngormEvent = new CairngormEvent(ConferenceEvents.CONNECTED_EVENT);
			dispatcher.dispatchEvent(event);
		}

		
		public function sendDisconnectedEvent(reason : uint, message : String):void
		{
			var event : DisconnectedEvent = new DisconnectedEvent(ConferenceEvents.DISCONNECTED_EVENT,
												reason, message);
			dispatcher.dispatchEvent(event);
		}
	}
}