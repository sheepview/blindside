package org.blindsideproject.core.apps.conference.controller.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.conference.controller.ConferenceController;

	public class ChangeStatusCommand extends CairngormEvent
	{
		public var newStatus : String;
		
		public function ChangeStatusCommand(newStatus : String) : void {
			super(ConferenceController.CHANGE_STATUS_COMMAND);
			this.newStatus = newStatus;
		}
		
		public function getNewStatus() : String
		{
			return newStatus;
		}
	}
}