package org.red5.samples.publisher.control
{
	import com.adobe.cairngorm.control.FrontController;
	
	import org.red5.samples.publisher.control.handlers.*;
	
	public class PublisherController extends FrontController
	{
		/**
		 *
		 */		
		public function PublisherController()
		{
			addCommand( PublisherController.SETUP_DEVICES_COMMAND, SetupDevicesCommandHandler );
						
			addCommand( PublisherController.ENABLE_AUDIO_COMMAND, EnableAudioCommandHandler );
			addCommand( PublisherController.ENABLE_VIDEO_COMMAND, EnableVideoCommandHandler );
			
			addCommand( PublisherController.START_CAMERA_COMMAND, StartCameraCommandHandler );
			addCommand( PublisherController.STOP_CAMERA_COMMAND, StopCameraCommandHandler );
			
			addCommand( PublisherController.START_MICROPHONE_COMMAND, StartMicrophoneCommandHandler );
			addCommand( PublisherController.STOP_MICROPHONE_COMMAND, StopMicrophoneCommandHandler );
			
			addCommand( PublisherController.SETUP_CONNECTION_COMMAND, SetupConnectionCommandHandler );
			addCommand( PublisherController.START_CONNECTION_COMMAND, StartConnectionCommandHandler );
			addCommand( PublisherController.CLOSE_CONNECTION_COMMAND, CloseConnectionCommandHandler );
			
			addCommand( PublisherController.SETUP_STREAMS_COMMAND, SetupStreamsCommandHandler );
			addCommand( PublisherController.STOP_STREAM_COMMAND, StopStreamCommandHandler );
			addCommand( PublisherController.PLAY_STREAM_COMMAND, PlayStreamCommandHandler );
			addCommand( PublisherController.PAUSE_STREAM_COMMAND, PauseStreamCommandHandler );
			addCommand( PublisherController.RESUME_STREAM_COMMAND, ResumeStreamCommandHandler );
			addCommand( PublisherController.PUBLISH_STREAM_COMMAND, PublishStreamCommandHandler );
			addCommand( PublisherController.UNPUBLISH_STREAM_COMMAND, UnpublishStreamCommandHandler );
		}
	
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
	}
}