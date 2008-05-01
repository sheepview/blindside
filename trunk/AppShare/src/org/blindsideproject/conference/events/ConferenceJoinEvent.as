package org.blindsideproject.conference.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.conference.control.ConferenceController;
	import org.blindsideproject.conference.model.Conference;
	
	public class ConferenceJoinEvent extends CairngormEvent
	{	
		private var conference : Conference;
		
		public function ConferenceJoinEvent(conference : Conference)
		{
			super(ConferenceController.JOIN_COMMAND);
			this.conference = conference;
		}
		
		public function getConference() : Conference
		{
			return conference;
		}
	}
}