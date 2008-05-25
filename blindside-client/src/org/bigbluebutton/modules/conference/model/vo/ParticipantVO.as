package org.bigbluebutton.modules.conference.model.vo
{
	public class ParticipantVO
	{
		public var username : String;
		public var userId : Number;
		public var role : String = Role.VIEWER;
		
		public function ParticipantVO(username : String, userId : Number, role : String)
		{
			this.username = username;
			this.userId = userId;
			this.role = role;
		}

	}
}