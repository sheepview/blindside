package org.red5.samples.publisher.vo
{
	import org.red5.samples.publisher.MediaType;
	import org.red5.samples.publisher.model.PublisherModel;
	import org.red5.samples.publisher.model.PublisherModelLocator;
	import org.red5.samples.publisher.business.PlayStreamDelegate;
	import flash.media.Video;
	import org.red5.samples.publisher.vo.settings.VideoSettings;
	
	[Bindable]	
	public class PlayMedia implements IMedia
	{
		private var model : PublisherModel = PublisherModelLocator.getInstance().model;
		
		private static const _type : MediaType = MediaType.PLAY;
		
		public var streamName : String;
		public var uri : String;
		
		public var connected : Boolean = model.connected;

		public var remoteVideo : Video;
		public var defaultVideoSettings : VideoSettings = new VideoSettings();
		
		public var playState : PlaybackState = PlaybackState.STOPPED;
		
		public var playStreamDelegate : PlayStreamDelegate;
		
		public function PlayMedia(streamName : String)
		{
			this.streamName = streamName;
		}

		public function get type() : MediaType
		{
			return _type;
		}
	}
}