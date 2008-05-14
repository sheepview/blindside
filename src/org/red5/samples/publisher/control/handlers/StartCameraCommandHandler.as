package org.red5.samples.publisher.control.handlers 
{	
	 
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
		
	import flash.events.*;
	import flash.media.*;
	import flash.net.NetStream;
	
	import org.red5.samples.publisher.control.commands.StartCameraCommand;
	import org.red5.samples.publisher.model.*;
	import org.red5.samples.publisher.vo.BroadcastMedia;
	
	public class StartCameraCommandHandler implements ICommand 
	{		
		private var modelLoc : PublisherModelLocator = PublisherModelLocator.getInstance();
		private var model : PublisherModel = modelLoc.model;
		
	 	private var log : ILogger = LoggerModelLocator.getInstance().log;
	 	
	 	private var camera : Camera; 	
	 	private var videoLocal : Video;
	 		
	 	public function execute( cgEvent : CairngormEvent ) : void
	    { 
			var cmd : StartCameraCommand = StartCameraCommand( cgEvent );
			var streamName : String = cmd.stream;
			
			var media : BroadcastMedia = model.getBroadcastMedia(streamName) as BroadcastMedia;
			
			var selectedCamIndex : int = 	media.video.settings.cameraIndex;
			var keyFrameInterval : int = 	media.video.settings.keyframe;
			var cameraWidth : int = 		media.video.settings.width;
			var cameraHeight : int = 		media.video.settings.height;
			var cameraFPS : int = 			media.video.settings.fps;
			var cameraBandwidth : int = 	media.video.settings.bandwidth;
			var cameraQuality : int = 		media.video.settings.quality;
			var cameraIndex : String =		String( selectedCamIndex - 1 );
			
			media.video.cam = Camera.getCamera( cameraIndex );
			
			camera = media.video.cam;
			camera.setKeyFrameInterval( keyFrameInterval );
			camera.setMode( cameraWidth, cameraHeight, cameraFPS );
			camera.setQuality( cameraBandwidth, cameraQuality );
			
			camera.addEventListener( ActivityEvent.ACTIVITY, activityEventHandler );
			camera.addEventListener( StatusEvent.STATUS, statusEventHandler );
			
			// update video stream when publishing
			if ( media.broadcastStreamDelegate.nsPublish != null ) 
			{
				media.broadcastStreamDelegate.nsPublish.attachCamera( camera );
			}
			
			log.debug( "StartCameraCommand::Started video device <b>" + camera.name + "</b>");
			
			media.video.localVideo = new Video( 320, 240 );
			media.video.localVideo.attachCamera( camera );

			media.deviceStarted = true;
		}
			
		private function activityEventHandler( event : ActivityEvent ) : void 
		{
//			log.debug( "StartCameraCommand::activityEventHandler: " + event );
		}
				
		private function statusEventHandler( event : StatusEvent ) : void 
		{
//			log.debug( "StartCameraCommand::statusEventHandler: " + event );
		}
		
	}
}