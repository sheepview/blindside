package org.bigbluebutton.modules.video.model.vo
{
	import flash.media.Microphone;
	
	import org.bigbluebutton.modules.video.model.vo.settings.AudioSettings;
	
	[Bindable]
	public class AudioStream
	{
		public var mic : Microphone;
		
		public var settings:AudioSettings = new AudioSettings();
	}
}