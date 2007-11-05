package org.blindsideproject.core.apps.voiceconference.controller.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.voiceconference.controller.VoiceConferenceController;

	public class LeaveCommand extends CairngormEvent
	{	
		public function LeaveCommand()
		{
			super(VoiceConferenceController.LEAVE_COMMAND);
		}
	}
}