package org.bigbluebutton.modules.voiceconference.control.notifiers
{
	/**
	 * A wrapper class so that multiple pieces of information can be sent inside a PureMVC notification 
	 * @author dzgonjan
	 * 
	 */	
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