package org.blindsideproject.core.apps.presentation.controller.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.presentation.controller.PresentationController;

	public class StartSharingCommand extends CairngormEvent
	{
		public function StartSharingCommand() : void
		{
			super(PresentationController.START_SHARE_COMMAND);
		}		
	}
}