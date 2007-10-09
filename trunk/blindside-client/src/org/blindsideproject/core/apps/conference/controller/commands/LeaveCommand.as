package org.blindsideproject.core.apps.conference.controller.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.conference.controller.ConferenceController;
	
	public class LeaveCommand extends CairngormEvent
	{	
		public function LeaveCommand()
		{
			super(ConferenceController.LEAVE_COMMAND);
		}
	}
}