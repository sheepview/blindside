package org.bigbluebutton.modules.video.model.vo
{
	import flash.media.Video;
	
	import org.bigbluebutton.modules.video.VideoFacade;
	import org.bigbluebutton.modules.video.model.business.MediaType;
	import org.bigbluebutton.modules.video.model.business.PublisherModel;
	import org.bigbluebutton.modules.video.model.services.PlayStreamDelegate;
	import org.bigbluebutton.modules.video.model.vo.settings.VideoSettings;
	
	[Bindable]	
	public class PlayMedia implements IMedia
	{
		private var model:PublisherModel =
		 	VideoFacade.getInstance().retrieveProxy(PublisherModel.NAME) as PublisherModel;
		
		private static const _type : MediaType = MediaType.PLAY;
		
		public var streamName : String;
		public var uri : String;
		
		public var connected : Boolean = model.connected;

		public var remoteVideo : Video;
		public var defaultVideoSettings:VideoSettings = new VideoSettings();
		
		public var playState : PlaybackState = PlaybackState.STOPPED;
		
		public var playStreamDelegate:PlayStreamDelegate;
		
		public function PlayMedia(streamName : String)
		{
			this.streamName = streamName;
		}

		public function get type():MediaType
		{
			return _type;
		}
	}
}