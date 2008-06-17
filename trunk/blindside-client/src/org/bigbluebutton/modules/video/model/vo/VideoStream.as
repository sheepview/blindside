package org.bigbluebutton.modules.video.model.vo
{
	import flash.media.Camera;
	import flash.media.Video;
	
	import org.bigbluebutton.modules.video.model.vo.settings.VideoSettings;
	
	[Bindable]
	public class VideoStream
	{
		public var cam : Camera;
		public var settings:VideoSettings = new VideoSettings();
		public var localVideo : Video;
	}
}