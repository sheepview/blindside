package org.blindsideproject.core.apps.presentation.controller.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.presentation.controller.PresentationController;
	
	public class ClearCommand extends CairngormEvent
	{
		public function ClearCommand() : void
		{
			super(PresentationController.CLEAR_COMMAND);
		}		
	}
}