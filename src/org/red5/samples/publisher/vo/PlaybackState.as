package org.red5.samples.publisher.vo
{
	public final class PlaybackState
	{
		public static const STOPPED : PlaybackState = new PlaybackState(0, "STOPPED");
		public static const PLAYING : PlaybackState = new PlaybackState(1, "PLAYING");
		public static const PAUSED : PlaybackState = new PlaybackState(2, "PAUSED");
		
		private var _value : int;
		private var _name : String;
		
		function PlaybackState(value : int, name : String)
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