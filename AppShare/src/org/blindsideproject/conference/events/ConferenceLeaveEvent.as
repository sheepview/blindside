package org.blindsideproject.conference.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.conference.control.ConferenceController;
	import org.blindsideproject.conference.model.Conference;
	
	public class ConferenceLeaveEvent extends CairngormEvent
	{	
		private var conference : Conference;
		
		public function ConferenceLeaveEvent(conference : Conference)
		{
			super(ConferenceController.LEAVE_COMMAND);
			this.conference = conference;
		}
		
		public function getConference() : Conference
		{
			return conference;
		}
	}
}