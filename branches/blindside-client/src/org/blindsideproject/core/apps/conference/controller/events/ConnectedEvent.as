package org.blindsideproject.core.apps.conference.controller.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class ConnectedEvent extends CairngormEvent
	{
		public function ConnectedEvent() : void
		{
			super(ConferenceEvents.CONNECTED_EVENT);
		}
	}
}