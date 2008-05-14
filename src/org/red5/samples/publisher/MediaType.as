package org.red5.samples.publisher
{
	public final class MediaType
	{
		public static const PLAY : MediaType = new MediaType(0, "PLAY");
		public static const BROADCAST : MediaType = new MediaType(1, "BROADCAST");
	
		private var _value : int;
		private var _name : String;
		
		function MediaType(value : int, name : String)
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