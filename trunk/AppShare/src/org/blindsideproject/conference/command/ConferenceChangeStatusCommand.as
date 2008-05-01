package org.blindsideproject.conference.command
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	import flash.events.Event;
	import org.blindsideproject.conference.model.Conference;
	import org.blindsideproject.conference.events.ChangeStatusEvent;
	
	public class ConferenceChangeStatusCommand implements ICommand
	{
		public function execute(cgEvent:CairngormEvent):void
		{
			var event : ChangeStatusEvent = ChangeStatusEvent(cgEvent);
			
			var conference : Conference = event.getConference();
			
			conference.getConnection().sendNewStatus();
			
		}
		
		
	}
}