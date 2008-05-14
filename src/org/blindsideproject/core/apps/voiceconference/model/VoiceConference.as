package org.blindsideproject.core.apps.voiceconference.model
{
	import org.blindsideproject.core.IApplication;
	import mx.collections.ArrayCollection;
	import org.blindsideproject.core.apps.voiceconference.vo.VoiceUser
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
	
	public class VoiceConference
	{
		private var log : ILogger = LoggerModelLocator.getInstance().log;
				
		[Bindable] public var users : ArrayCollection = null;				
		[Bindable] public var connected : Boolean = false;
		
		public var connectFailReason : String;		
		public var host : String;
		public var room : String;
		
		public function VoiceConference() : void
		{
			users = new ArrayCollection();
		}

		public function addUser(newuser : VoiceUser) : void
		{				
							
		}

		public function hasUser(id : Number) : Boolean
		{						
			return false;		
		}
		
		public function getUser(id : Number) : VoiceUser
		{						
			return null;				
		}

		public function removeUser(userid : Number) : void
		{
							
		}
		
		private function getUserIndex(userid : Number) : int
		{			
			// Participant not found.
			return -1;
		}

		public function removeAllUsers() : void
		{

		}		

		public function newUserStatus(id : Number, newStatus : String) : void
		{
	
		}
		
		private function sort() : void
		{
				
		}				
	}
}