package org.bigbluebutton.modules.video.control.notifiers
{
	public class PlayStreamNotifier
	{
		public var streamName:String;
		public var enableVideo:Boolean;
		public var enableAudio:Boolean;
		
		public function PlayStreamNotifier(streamName:String, enableVideo:Boolean, enableAudio:Boolean)
		{
			this.streamName = streamName;
			this.enableAudio = enableAudio;
			this.enableVideo = enableVideo;
		}

	}
}