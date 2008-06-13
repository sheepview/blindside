package org.bigbluebutton.modules.viewers.controller.notifiers
{
	public class StatusNotifier
	{
		public var userid:Number;
		public var newStatus:String;
		
		public function StatusNotifier(userid:Number, newStatus:String)
		{
			this.newStatus = newStatus;
			this.userid = userid;
		}

	}
}