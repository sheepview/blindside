package org.blindsideproject.core.apps.presentation.controller.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.presentation.controller.PresentationController;
	
	public class LeaveCommand extends CairngormEvent
	{
		public function LeaveCommand() : void
		{
			super(PresentationController.LEAVE_COMMAND);
		}		
	}
}