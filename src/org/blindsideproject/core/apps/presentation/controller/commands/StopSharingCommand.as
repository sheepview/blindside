package org.blindsideproject.core.apps.presentation.controller.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.presentation.controller.PresentationController;
	
	public class StopSharingCommand extends CairngormEvent
	{
		public function StopSharingCommand() : void
		{
			super(PresentationController.STOP_SHARE_COMMAND);
		}		
	}
}