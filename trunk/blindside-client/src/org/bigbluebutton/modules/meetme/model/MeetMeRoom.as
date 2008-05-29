package org.bigbluebutton.modules.meetme.model
{
	import mx.collections.ArrayCollection;
	
	import org.bigbluebutton.modules.meetme.MeetMeFacade;
	import org.bigbluebutton.modules.meetme.model.business.NetConnectionDelegate;
 	
	/**
	 * This class represents a room in the Asterisk server. The information about the participants is held
	 * in the public variable dpParticipants:ArrayCollection
	 * @authorRichard Alam
	 * 
	 */ 	
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
		
		/**
		 *  
		 * @param uri - the uri of this room
		 * 
		 */		
		public function setUri(uri : String) : void
		{
			this.uri = uri;
		}
		
		/**
		 * 
		 * @return - the uri of this room
		 * 
		 */		
		public function getUri() : String
		{
			return uri;
		}
		
		/**
		 * Sets the NetCnnectionDelegate of this room 
		 * @param connection
		 * 
		 */		
		public function setConnectionDelegate(connection:NetConnectionDelegate) : void
		{
			netConnection = connection;
		}
		
		/**
		 *  
		 * @return The NetConnectionDelegate of the MeetMe module
		 * 
		 */		
		public function getConnection() : NetConnectionDelegate {
			return MeetMeFacade.getInstance().retrieveProxy(NetConnectionDelegate.NAME) as NetConnectionDelegate;
		}
	}
}