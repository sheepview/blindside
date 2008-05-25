package org.bigbluebutton.modules.conference.model.vo
{
	import mx.collections.ArrayCollection;
	
	public class ConferenceVO
	{
		private var meVO : UserVO;
		private var participantsVO : ArrayCollection = new ArrayCollection();
		
		public function ConferenceVO() {}

		public function get me() : UserVO
		{
			return meVO;
		}
		
		public function set me(u : UserVO) : void
		{
			meVO = u;
		}
		
		public function get participants() : ArrayCollection
		{
			return participantsVO;
		}
		
		public function addParticipant(p : ParticipantVO) : void
		{
			participantsVO.addItem(p);
		}

		public function hasParticipant(id : Number) : Boolean
		{
			var index : int = getParticipantIndex(id);
			
			if (index > -1) {
				return true;
			}
						
			return false;		
		}
		
		public function getParticipant(id : Number) : ParticipantVO
		{
			var index : int = getParticipantIndex(id);
			
			if (index > -1) {
				return participants.getItemAt(index) as ParticipantVO;
			}
						
			return null;				
		}

		public function removeParticipant(userid : Number) : void
		{
			var index : int = getParticipantIndex(userid);
			if (index > -1) {
				participants.removeItemAt(index);
			}							
		}
		
		private function getParticipantIndex(userid : Number) : int
		{
			var part : ParticipantVO;
			
			for (var i:int = 0; i < participants.length; i++)
			{
				part = participants.getItemAt(i) as ParticipantVO;
				
				if (part.userId == userid) {
					return i;
				}
			}				
			
			// Participant not found.
			return -1;
		}

		public function removeAllParticipants() : void
		{
			participants.removeAll();
		}		
	}
}