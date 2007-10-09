package org.red5.samples.publisher.business
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;

	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
		
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;
	
	import mx.rpc.IResponder;
	
	import org.red5.samples.publisher.control.commands.*;
	import org.red5.samples.publisher.model.*;
	import org.red5.samples.publisher.view.general.Images;
	import org.red5.samples.publisher.vo.BroadcastMedia;	
	
	public class BroadcastStreamDelegate
	{	
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		
		private var modelLoc : PublisherModelLocator = 	PublisherModelLocator.getInstance();
		private var model : PublisherModel = modelLoc.model;	
		
		private var media : BroadcastMedia;
			
		public var nsPublish : NetStream;
			
		public function BroadcastStreamDelegate( broadcastMedia : BroadcastMedia )
		{
			media = broadcastMedia;
		}
						
		public function startPublish( publishMode : String, streamName : String ) : void
		{
			if (! model.connected) return;
			
			try 
			{
				var camera : Camera = media.video.cam;
				var microphone : Microphone = media.audio.mic;
				
				if ( microphone != null || camera != null ) 
				{
					// close previous stream
					if ( nsPublish != null ) 
					{
						// Stop and unpublish current NetStream.
						var unpublishStreamCmd : UnpublishStreamCommand = new UnpublishStreamCommand(streamName);
						unpublishStreamCmd.dispatch();
					}
					// Setup NetStream for publishing.
					nsPublish = new NetStream( modelLoc.netConnDelegate.connection );
					//
					nsPublish.addEventListener( NetStatusEvent.NET_STATUS, netStatusEvent );
					nsPublish.addEventListener( IOErrorEvent.IO_ERROR, netIOError );
					nsPublish.addEventListener( AsyncErrorEvent.ASYNC_ERROR, netASyncError );
					
					nsPublish.client = this;	
					
					// attach devices to NetStream.
					if ( camera != null ) 
					{
						nsPublish.attachCamera( camera );
					}
					if ( microphone != null) 
					{
						nsPublish.attachAudio( microphone );
					}
					
					media.broadcasting = true;
					// Start publishing.
					nsPublish.publish( streamName, publishMode );
				} 
				else 
				{
					log.warn( "StreamDelegate::Can't publish stream, no input device(s) selected" );
					
					media.broadcasting = false;
				}
			}
			catch( e : ArgumentError ) 
			{				
				media.broadcasting = false;
			
				// Invalid parameters
				switch ( e.errorID ) 
				{
					// NetStream object must be connected.
					case 2126 :
						//
						log.error( "StreamDelegate::Can't publish stream, not connected to server" );
						break;
					//
					default :
					   //
					   log.error( "StreamDelegate::" + e.toString());
					   break;
				}
			}
		}
			
		public function stopPublish() : void
		{	
			nsPublish.close();	
			media.broadcasting = false;
		}
		
		public function stopMicrophone() : void
		{
			// update audio stream when publishing
			if ( nsPublish != null ) 
			{
				nsPublish.attachAudio( null );
			}				
		}	
		
		public function stopCamera() : void
		{
			// Update video stream when publishing.
			if ( nsPublish != null ) 
			{
				nsPublish.attachCamera( null );
			}			
		}
							
		protected function netStatusEvent( event : NetStatusEvent ) : void 
		{
			handleResult( event );
		}
		
		protected function netSecurityError( event : SecurityErrorEvent ) : void 
		{
			// Pass SecurityErrorEvent to Command.
		    handleFault( new SecurityErrorEvent ( SecurityErrorEvent.SECURITY_ERROR, false, true,
		    										  "Security error - " + event.text ) );
		}
			
		protected function netIOError( event : IOErrorEvent ) : void 
		{
			// Pass IOErrorEvent to Command.
			handleFault( new IOErrorEvent ( IOErrorEvent.IO_ERROR, false, true, 
							 "Input/output error - " + event.text ) );
		}
				
		protected function netASyncError( event : AsyncErrorEvent ) : void 
		{
			// Pass AsyncErrorEvent to Command.
			handleFault( new AsyncErrorEvent ( AsyncErrorEvent.ASYNC_ERROR, false, true,
							 "Asynchronous code error - <i>" + event.error + "</i>" ) );
		}
	
		public function handleResult(  event : Object  ) : void 
		{
			var info : Object = event.info;
			var statusCode : String = info.code;

			switch ( statusCode ) {
				case "NetStream.Play.Start" :
					// Shouldn't be getting this playback since we are broadcasting
					log.warn("NetStream.Play.Start for broadcast stream [" + media.streamName + "]");
					break;
					
				case "NetStream.Play.Stop":	
					// Shouldn't be getting this playback since we are broadcasting
					log.warn("NetStream.Play.Stop for broadcast stream [" + media.streamName + "]");		
					break;
				
				case "NetStream.Buffer.Empty":	
					// Shouldn't be getting this playback since we are broadcasting
					log.warn("NetStream.Buffer.Empty for broadcast stream [" + media.streamName + "]");	
					break;
				
				case "NetStream.Play.UnpublishNotify":
					// Shouldn't be getting this playback since we are broadcasting
					log.warn("NetStream.Play.UnpublishNotify for broadcast stream [" + media.streamName + "]");
					break;
					
				case "NetStream.Play.StreamNotFound":
					// Shouldn't be getting this playback since we are broadcasting
					log.warn("NetStream.Play.StreamNotFound for broadcast stream [" + media.streamName + "]");
					break;
				
				case "NetStream.Pause.Notify":
					// Shouldn't be getting this playback since we are broadcasting
					log.warn("NetStream.Pause.Notify for broadcast stream [" + media.streamName + "]");				
					break;
					
				case "NetStream.Unpause.Notify":
					// Shouldn't be getting this playback since we are broadcasting
					log.warn("NetStream.Unpause.Notify for broadcast stream [" + media.streamName + "]");
					break;
					
				case "NetStream.Publish.Start":
					media.broadcasting = true;
					log.info("NetStream.Publish.Start for broadcast stream [" + media.streamName + "]");
					break;
					
				case "NetStream.Publish.Idle":
					log.info("NetStream.Publish.Idle for broadcast stream [" + media.streamName + "]");
					break;
					
				case "NetStream.Record.Failed":
					log.info("NetStream.Record.Failed for broadcast stream [" + media.streamName + "]");
					publishStopped();
					break;
					
				case "NetStream.Record.Stop":
					log.info("NetStream.Record.Stop for broadcast stream [" + media.streamName + "]");
					publishStopped();
					break;
					
				case "NetStream.Record.Start":
					log.info("NetStream.Record.Start for broadcast stream [" + media.streamName + "]");
					media.broadcasting = true;
					break;
					
				case "NetStream.Unpublish.Success":
					log.info("NetStream.Unpublish.Success for broadcast stream [" + media.streamName + "]");
					publishStopped();
					break;
					
				case "NetStream.Publish.BadName":
					log.info("NetStream.Publish.BadName for broadcast stream [" + media.streamName + "]");
					publishStopped();
					break;
			}
		}
				
			
		private function publishStopped() : void 
		{
			media.broadcasting = false;
		}
				
		public function handleFault(  event : Object  ) : void
		{			
			log.error("BroadcastStreamDelegate::" + event.text );
			stopPublish();
		}
			
		public function onPlayStatus( info : Object ) : void 
		{	
			log.debug("BroadcastStreamDelegate::Playback - " + info.code  );
		}
			
		public function onMetaData ( info : Object ) : void 
		{
			for ( var d : String in info ) 
			{
				log.info( "Metadata - " + d + ": " + info[ d ]);
			}
		}
					
		public function onCuePoint( info : Object ) : void 
		{
			for ( var d : String in info ) 
			{
				log.info( "Cuepoint - " + d + ": " + info[ d ] );
			}
		}
		
    }
}