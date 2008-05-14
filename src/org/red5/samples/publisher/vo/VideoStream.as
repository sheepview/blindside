package org.red5.samples.publisher.vo
{
	import flash.media.Camera;
	import org.red5.samples.publisher.vo.settings.VideoSettings;
	import flash.media.Video;
	
	[Bindable]
	public class VideoStream
	{
		public var cam : Camera;
		public var settings : VideoSettings = new VideoSettings();
		public var localVideo : Video;
	}
}