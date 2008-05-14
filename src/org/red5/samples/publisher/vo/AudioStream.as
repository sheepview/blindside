package org.red5.samples.publisher.vo
{
	import flash.media.Microphone;
	import org.red5.samples.publisher.vo.settings.AudioSettings;
	
	[Bindable]
	public class AudioStream
	{
		public var mic : Microphone;
		
		public var settings : AudioSettings = new AudioSettings();
	}
}