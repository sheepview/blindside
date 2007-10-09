package org.blindsideproject.core.apps.chat.controller.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.chat.controller.ChatController;
	
	public class LeaveCommand extends CairngormEvent
	{	
		public function LeaveCommand()
		{
			super(ChatController.LEAVE_COMMAND);
		}
	}
}