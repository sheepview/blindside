package org.blindsideproject.conference.model
{

	/**
	 * This class will hold all the conferences that
	 * the user is a participant.
	 */
	public class ConferenceManager
	{
		// Let's support one conference for now.
		private var conferenceMap : Conference;
		private var conferenceServiceUri : String;
		
		public function setConferenceServiceUri(uri : String) : void {
			this.conferenceServiceUri = uri;
		}
		
		public function setConference(conference : Conference) : void
	   	{
	   		this.conferenceMap = conference;
	   	}
	   	
	   	public function getConference(room : String) : Conference
	   	{
	   		if (conferenceMap.getRoom() == room)
	   			return conferenceMap;
	   			
	   		return null;
	   	}
	}
}