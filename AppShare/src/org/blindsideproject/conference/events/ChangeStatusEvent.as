package org.blindsideproject.conference.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.conference.model.Conference;
	import org.blindsideproject.conference.control.ConferenceController;

	public class ChangeStatusEvent extends CairngormEvent
	{
		private var conference : Conference;
		
		public function ChangeStatusEvent(conference : Conference) {
			super(ConferenceController.CHANGE_STATUS_COMMAND);
			this.conference = conference;
		}
		
		public function getConference() : Conference {
			return conference;
		}
	}
}