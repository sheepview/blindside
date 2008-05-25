package org.bigbluebutton.modules.conference.model.vo
{
	public class UserVO
	{
		public var username : String;
		public var password : String;
		public var conference : String;
		public var authToken : String;
		public var userId : Number;
		public var role : String = Role.VIEWER;
					
		public function UserVO(name : String, pass : String, conf : String)
		{
			username = name;
			password = pass;
			conference = conf;
		}

	}
}