package org.blindsideproject.core.apps.conference.controller.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.conference.controller.ConferenceController;
	import org.blindsideproject.core.apps.conference.controller.*;
	
	public class JoinCommand extends CairngormEvent
	{	
		private var _username : String;
		private var _password : String;
		private var _room : String;
		private var _host : String;
		
		public function JoinCommand(username : String, password : String, 
				room : String, host : String) : void
		{
			super(ConferenceController.JOIN_COMMAND);
			_username = username;
			_room = room;
			_password = password;
			_host = host;
		}
		
		public function get username() : String
		{
			return _username;
		}
		
		public function get room() : String
		{
			return _room;
		}
		
		public function get password() : String
		{
			return _password;
		}
		
		public function get host() : String
		{
			return _host;
		}
	}
}