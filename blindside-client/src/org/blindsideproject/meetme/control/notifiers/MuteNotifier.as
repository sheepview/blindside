package org.blindsideproject.meetme.control.notifiers
{
	public class MuteNotifier
	{
		public var _userid:Number;
		public var _muteUser:Boolean;
		
		public function MuteNotifier(userid:Number, muteUser:Boolean)
		{
			this._userid = userid;
			this._muteUser = muteUser;
		}

	}
}