package org.blindsideproject.conference.command
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	
	import org.blindsideproject.conference.model.ConferenceModelLocator;
	import org.blindsideproject.conference.model.Conference;
	import org.blindsideproject.conference.business.NetConnectionDelegate;
	import org.blindsideproject.conference.control.ConferenceEvents;
	import org.blindsideproject.util.components.logger.model.Logger;
	import org.blindsideproject.conference.events.ConferenceJoinEvent;
		
	import mx.rpc.IResponder;
		
	public class ConferenceJoinCommand implements ICommand
	{		
		private var model : ConferenceModelLocator = ConferenceModelLocator.getInstance();
		private var log : Logger = model.getLogger();
		
		public function execute(cgEvent:CairngormEvent):void
		{
			var event : ConferenceJoinEvent = ConferenceJoinEvent(cgEvent);
	
			var connection : NetConnectionDelegate = new NetConnectionDelegate(event.getConference());
			
			log.debug("Executing joinCommand for [" + event.getConference().getRoom() + "]");
			
			connection.connect();
		}
	}
}