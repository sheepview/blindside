package org.bigbluebutton.modules.presentation.controller.notifiers
{
	/**
	 * This is a convinience class so that multiple pieces of data can be sent through a pureMVC notification
	 * @author dzgonjan
	 * 
	 */	
	public class JoinNotifier
	{
		private var _userid:Number;
		private var _url:String;
		private var _room:String;
		
		public function JoinNotifier(userid:Number, url:String, room:String)
		{
			this._userid = userid;
			this._url = url;
			this._room = room;
		}
		
		public function get userid():Number{
			return this._userid;
		}
		
		public function get url():String{
			return this._url;
		}
		
		public function get room():String{
			return this._room;
		}

	}
}