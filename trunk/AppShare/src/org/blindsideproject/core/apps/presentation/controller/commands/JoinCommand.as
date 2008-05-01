package org.blindsideproject.core.apps.presentation.controller.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.presentation.controller.PresentationController;

	public class JoinCommand extends CairngormEvent
	{
		private var _host : String;
		private var _room : String;
		private var _userid : Number;
		
		public function JoinCommand(userid : Number, host : String, room : String) : void
		{
			super(PresentationController.JOIN_COMMAND);
			_host = host;
			_room = room;
			_userid = userid;
		}		
		
		public function get host() : String
		{
			return _host;
		}
		
		public function get room() : String
		{
			return _room;
		}
		
		public function get userid() : Number
		{
			return _userid;
		}
	}
}