package org.bigbluebutton.modules.video.model.business
{	 
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;
	
	import mx.events.*;
	
	import org.bigbluebutton.modules.video.model.vo.BroadcastMedia;
	import org.bigbluebutton.modules.video.model.vo.IMedia;
	import org.bigbluebutton.modules.video.model.vo.PlayMedia;
	import org.bigbluebutton.modules.video.model.vo.settings.GeneralSettings;
	import org.bigbluebutton.modules.video.model.vo.settings.VideoSettings;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class PublisherModel extends Proxy implements IProxy
	{		
		public static const NAME:String = "PublisherModel";
		[Bindable] public var connected : Boolean = false;
		
		public var playMedia : Object;
		public var broadcastMedia : Object;
				
		public var generalSettings:GeneralSettings;
		public var defaultVideoSettings:VideoSettings;
				 
		[Bindable]		
		public var cameraNames : Array = 	[ "No video" ];
		
		[Bindable]	
		public var microphoneNames : Array = [ "No audio" ];		
				 	
		public function PublisherModel()
		{
			super(NAME);
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
		
		public function getBroadcastMedia(streamName : String):IMedia
		{
			return broadcastMedia[streamName];
		}

		public function getPlayMedia(streamName : String) : IMedia
		{
			return playMedia[streamName];
		}
	}
}