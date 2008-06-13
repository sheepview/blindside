package org.bigbluebutton.modules.viewers.controller.notifiers
{
	public class LoginInfoNotifier
	{
		public var name:String;
		public var password:String;
		public var room:String;
		
		public function LoginInfoNotifier(name:String, password:String, room:String)
		{
			this.name = name;
			this.password = password;
			this.room = room;
		}

	}
}