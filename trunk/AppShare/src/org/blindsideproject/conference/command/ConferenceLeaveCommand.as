package org.blindsideproject.conference.command
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	import org.blindsideproject.conference.model.ConferenceModelLocator;
	import org.blindsideproject.conference.model.Conference;
	import org.blindsideproject.conference.events.ConferenceLeaveEvent;
	
	public class ConferenceLeaveCommand implements ICommand
	{
		private var model : ConferenceModelLocator = ConferenceModelLocator.getInstance();		
		private var conference : Conference;
		
		public function execute(cgEvent : CairngormEvent):void
		{
			var event : ConferenceLeaveEvent = ConferenceLeaveEvent(cgEvent);
			event.getConference().getConnection().close();
		}
		
	}
}