package org.bigbluebutton.modules.video.model.vo
{
	public final class BroadcastMode
	{
		public static const RECORD : BroadcastMode = new BroadcastMode(0, "record");
		public static const LIVE : BroadcastMode = new BroadcastMode(1, "live");
		public static const APPEND : BroadcastMode = new BroadcastMode(2, "append");
		
		private var _value : int;
		private var _name : String;
		
		function BroadcastMode(value : int, name : String)
		{
			_value = value;
			_name = name;
		}
		
		public function get name() : String
		{
			return _name;
		}
		
		public function get value() : int
		{
			return value;
		}
	}
}