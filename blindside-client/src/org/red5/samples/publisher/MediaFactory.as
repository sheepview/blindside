package org.red5.samples.publisher
{
	internal final class MediaFactory
	{
		private var _playMedia : Object;
		private var _broadcastMedia : Object;
		
		public function MediaFactory(playMedia : Object, broadcastMedia : Object) {
			_playMedia = playMedia;
			_broadcastMedia = broadcastMedia;	
		}
		
		public function createMedia(type : MediaType, streamName : String) : Boolean
		{
			if (type == MediaType.BROADCAST) {
				_broadcastMedia[streamName] = new BroadcastMedia(streamName);
			} else if (type == MediaType.PLAY) {
				_playMedia[streamName] = new PlayMedia(streamName);
			}
		}
	}
}