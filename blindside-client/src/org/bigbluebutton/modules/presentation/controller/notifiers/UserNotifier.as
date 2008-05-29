package org.bigbluebutton.modules.presentation.controller.notifiers
{
	/**
	 * This is a convinience class so that multiple pieces of data can be sent via a pureMVC notification  
	 * @author dzgonjan
	 * 
	 */	
	public class UserNotifier
	{
		private var _userid:Number;
		private var _name:String;
		
		public function UserNotifier(userid:Number, name:String)
		{
			this._name = name;
			this._userid = userid;
		}
		
		public function get name():String{
			return this._name;
		}
		
		public function get userid():Number{
			return this._userid;
		}

	}
}