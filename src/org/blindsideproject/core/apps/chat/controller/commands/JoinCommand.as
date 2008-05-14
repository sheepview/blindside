package org.blindsideproject.core.apps.chat.controller.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.chat.controller.ChatController;

	public class JoinCommand extends CairngormEvent
	{
		private var _host : String;
		private var _room : String;
		
		public function JoinCommand(host : String, room : String) : void
		{
			super(ChatController.JOIN_COMMAND);
			_host = host;
			_room = room;
		}		
		
		public function get host() : String
		{
			return _host;
		}
		
		public function get room() : String
		{
			return _room;
		}
	}
}