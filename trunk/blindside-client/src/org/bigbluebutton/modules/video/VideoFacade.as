package org.bigbluebutton.modules.video
{
	import org.bigbluebutton.modules.video.control.StartupVideoCommand;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	public class VideoFacade extends Facade implements IFacade
	{
		public static const NAME:String = "VideoFacade";
		
		public static const STARTUP:String = "StartupVideo";
		public static const SETUP_DEVICES_COMMAND : String = 			"PUBLISHER_SETUP_DEVICES_COMMAND";		
		
		public static const ENABLE_AUDIO_COMMAND : String = 			"PUBLISHER_ENABLE_AUDIO_COMMAND";
		public static const ENABLE_VIDEO_COMMAND : String = 			"PUBLISHER_ENABLE_VIDEO_COMMAND";
			
		public static const START_CAMERA_COMMAND : String = 			"PUBLISHER_START_CAMERA_COMMAND";
		public static const STOP_CAMERA_COMMAND : String = 				"PUBLISHER_STOP_CAMERA_COMMAND";	
			
		public static const START_MICROPHONE_COMMAND : String = 		"PUBLISHER_START_MICROPHONE_COMMAND";
		public static const STOP_MICROPHONE_COMMAND : String = 			"PUBLISHER_STOP_MICROPHONE_COMMAND";		
	
		public static const START_CONNECTION_COMMAND : String = 		"PUBLISHER_START_CONNECTION_COMMAND";
		public static const CLOSE_CONNECTION_COMMAND : String = 		"PUBLISHER_CLOSE_CONNECTION_COMMAND";
		public static const SETUP_CONNECTION_COMMAND : String = 		"PUBLISHER_SETUP_CONNECTION_COMMAND";	
			
		public static const SETUP_STREAMS_COMMAND : String = 			"PUBLISHER_SETUP_STREAMS_COMMAND";
		public static const STOP_STREAM_COMMAND : String = 				"PUBLISHER_STOP_STREAM_COMMAND";
		public static const PLAY_STREAM_COMMAND : String = 				"PUBLISHER_PLAY_STREAM_COMMAND";
		public static const PAUSE_STREAM_COMMAND : String = 			"PUBLISHER_PAUSE_STREAM_COMMAND";
		public static const RESUME_STREAM_COMMAND : String = 			"PUBLISHER_RESUME_STREAM_COMMAND";
		public static const PUBLISH_STREAM_COMMAND : String = 			"PUBLISHER_PUBLISH_STREAM_COMMAND";
		public static const UNPUBLISH_STREAM_COMMAND : String = 		"PUBLISHER_UNPUBLISH_STREAM_COMMAND";
		
		public function VideoFacade()
		{
			super(NAME);
		}
		
		public static function getInstance():VideoFacade{
			if (instanceMap[NAME] == null) instanceMap[NAME] = new VideoFacade();
			return instanceMap[NAME] as VideoFacade;
		}
		
		override protected function initializeController():void{
			super.initializeController();
			registerCommand(STARTUP, StartupVideoCommand);
		}
		
		public function startup(app:VideoModule):void{
			sendNotification(STARTUP, app);
		}

	}
}