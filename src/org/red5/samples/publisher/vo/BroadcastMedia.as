package org.red5.samples.publisher.vo
{
	import org.red5.samples.publisher.business.BroadcastStreamDelegate;
	import org.red5.samples.publisher.model.PublisherModel;
	import org.red5.samples.publisher.model.PublisherModelLocator;
	import org.red5.samples.publisher.MediaType;
	
	[Bindable]
	public class BroadcastMedia implements IMedia
	{
		private var model : PublisherModel = PublisherModelLocator.getInstance().model;
		
		private static const _type : MediaType = MediaType.BROADCAST;
		
		public var streamName : String;
		public var uri : String;

		public var deviceStarted : Boolean = false;
		public var broadcasting : Boolean = false;
		
		public var connected : Boolean = model.connected;
		
		public var audio : AudioStream;
		public var video : VideoStream;
		public var broadcastMode : BroadcastMode = BroadcastMode.LIVE;
		public var broadcastStreamDelegate : BroadcastStreamDelegate;
		
		public function BroadcastMedia(streamName : String)
		{
			this.streamName = streamName;
			audio = new AudioStream();
			video = new VideoStream();
		}		
		
		public function get type() : MediaType
		{
			return _type;
		}
	}
}