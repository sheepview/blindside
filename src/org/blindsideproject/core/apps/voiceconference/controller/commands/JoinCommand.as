package org.blindsideproject.core.apps.voiceconference.controller.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.voiceconference.controller.VoiceConferenceController;
	
	public class JoinCommand extends CairngormEvent
	{	
		public var room : String;
		public var host : String;
		
		public function JoinCommand(room : String, host : String):void
		{
			super(VoiceConferenceController.JOIN_COMMAND);
			this.room = room;
			this.host = host;
		}
	}
}