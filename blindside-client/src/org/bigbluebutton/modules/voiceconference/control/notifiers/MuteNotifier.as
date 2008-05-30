package org.bigbluebutton.modules.voiceconference.control.notifiers
{
	/**
	 * A wrapper class so that multiple pieces of information can be sent inside a PureMVC notification 
	 * @author dzgonjan
	 * 
	 */	
	public class MuteNotifier
	{
		private var _userid:Number;
		private var _muteUser:Boolean;
		
		public function MuteNotifier(userid:Number, muteUser:Boolean)
		{
			this._userid = userid;
			this._muteUser = muteUser;
		}
		
		public function get userid():Number{
			return _userid;
		}
		
		public function get muteUser():Boolean{
			return _muteUser;
		}

	}
}