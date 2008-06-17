package org.bigbluebutton.modules.video.model.vo
{
	import org.bigbluebutton.modules.video.VideoFacade;
	import org.bigbluebutton.modules.video.model.business.MediaType;
	import org.bigbluebutton.modules.video.model.business.PublisherModel;
	import org.bigbluebutton.modules.video.model.services.BroadcastStreamDelegate;
	
	[Bindable]
	public class BroadcastMedia implements IMedia
	{
		private var model:PublisherModel= VideoFacade.getInstance().retrieveProxy(PublisherModel.NAME) as PublisherModel;
		
		private static const _type : MediaType = MediaType.BROADCAST;
		
		public var streamName : String;
		public var uri : String;

		public var deviceStarted : Boolean = false;
		public var broadcasting : Boolean = false;
		
		public var connected : Boolean = model.connected;
		
		public var audio : AudioStream;
		public var video : VideoStream;
		public var broadcastMode : BroadcastMode = BroadcastMode.LIVE;
		public var broadcastStreamDelegate:BroadcastStreamDelegate;
		
		public function BroadcastMedia(streamName : String)
		{
			this.streamName = streamName;
			audio = new AudioStream();
			video = new VideoStream();
		}		
		
		public function get type():MediaType
		{
			return _type;
		}
	}
}