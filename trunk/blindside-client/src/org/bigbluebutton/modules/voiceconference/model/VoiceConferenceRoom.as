package org.bigbluebutton.modules.voiceconference.model
{
	import mx.collections.ArrayCollection;
	
	import org.bigbluebutton.modules.voiceconference.VoiceConferenceFacade;
	import org.bigbluebutton.modules.voiceconference.model.business.NetConnectionDelegate;
 	
	/**
	 * This class represents a room in the Asterisk server. The information about the participants is held
	 * in the public variable dpParticipants:ArrayCollection
	 * @authorRichard Alam
	 * 
	 */ 	
	public class VoiceConferenceRoom
	{
					
		[Bindable]
		public var isConnected : Boolean;
		
		[Bindable]
		public var dpParticipants : ArrayCollection;
		
		private var room : String;
		private var uri : String;
		
		[Bindable]
		public var userRole : String;
		
		public function VoiceConferenceRoom(uri:String):void{
			this.uri = uri;
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
	}
}