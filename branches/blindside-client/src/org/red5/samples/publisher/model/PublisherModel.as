package org.red5.samples.publisher.model
{	 
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;
	
	import mx.events.*;
	
	import org.red5.samples.publisher.business.*;
	import org.red5.samples.publisher.view.general.Images;
	import org.red5.samples.publisher.vo.*;
	import org.red5.samples.publisher.vo.settings.*;
	import org.red5.samples.publisher.MediaType;
	
	public class PublisherModel
	{		
		[Bindable] public var connected : Boolean = false;
		
		public var playMedia : Object;
		public var broadcastMedia : Object;
				
		public var generalSettings : GeneralSettings;
		public var defaultVideoSettings : VideoSettings;
				 
		[Bindable]		
		public var cameraNames : Array = 	[ "No video" ];
		
		[Bindable]	
		public var microphoneNames : Array = [ "No audio" ];		
				 	
		public function PublisherModel()
		{
			// Create blank general settings VO.
			generalSettings = new GeneralSettings();
			defaultVideoSettings = new VideoSettings();

			playMedia  = new Object();
			broadcastMedia = new Object();
		}

		public function createBroadcastMedia(streamName : String) : void
		{
			broadcastMedia[streamName] = new BroadcastMedia(streamName);
		}

		public function createPlayMedia(streamName : String) : void
		{
			playMedia[streamName] = new PlayMedia(streamName);
		}
		
		public function getBroadcastMedia(streamName : String) : IMedia
		{
			return broadcastMedia[streamName];
		}

		public function getPlayMedia(streamName : String) : IMedia
		{
			return playMedia[streamName];
		}
	}
}