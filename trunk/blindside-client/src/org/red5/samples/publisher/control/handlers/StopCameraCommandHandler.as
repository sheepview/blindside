package org.red5.samples.publisher.control.handlers 
{	
	 
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
		
	import flash.events.*;
	import flash.media.Camera;
	
	import org.red5.samples.publisher.model.*;
	import org.red5.samples.publisher.control.commands.StopCameraCommand;
	import org.red5.samples.publisher.vo.BroadcastMedia;
	
	public class StopCameraCommandHandler implements ICommand 
	{		
		private var model : PublisherModel = PublisherModelLocator.getInstance().model;
 	
	 	public function execute( cgEvent : CairngormEvent ) : void
	    { 			
	    	var cmd : StopCameraCommand = StopCameraCommand(cgEvent);
	    	var media : BroadcastMedia = model.getBroadcastMedia(cmd.stream) as BroadcastMedia;
	    	
			//log.debug( "StopCameraCommand::Disabled video device" );

			//log.debug("Stopping camera[" + cmd.stream + "]");

			if (media == null) {
				//log.debug("Stopping camera[" + cmd.stream + "] with media NULL");
			}
			
			if (media.video.localVideo != null) {
				// Disconnect video device.
				media.video.localVideo.attachCamera( null );
				media.video.localVideo = null;
				media.broadcastStreamDelegate.stopCamera();
				media.deviceStarted = false;
			}
		}
		
	}
}