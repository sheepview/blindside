package org.blindsideproject.meetme.events
{
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class NewMeetMeEvent extends CairngormEvent
	{
		public function NewMeetMeEvent(type : String) : void
		{
			super(type);
		}
	}
}