package org.red5.samples.publisher.business
{

	import com.adobe.cairngorm.business.ServiceLocator;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;

	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerFacade;
		
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;
	
	import mx.rpc.IResponder;
	
	import org.red5.samples.publisher.control.commands.*;
	import org.red5.samples.publisher.model.*;
	import org.red5.samples.publisher.view.general.Images;
	import org.red5.samples.publisher.vo.PlayMedia;
	import org.red5.samples.publisher.vo.PlaybackState;	
	
	public class PlayStreamDelegate
	{		
		private var modelLoc : PublisherModelLocator = PublisherModelLocator.getInstance();
		private var model : PublisherModel = modelLoc.model;
			
		private var nsPlay : NetStream;
		
		private var media : PlayMedia;
		private var playbackFinished : Boolean = false;
				
		public function PlayStreamDelegate( playMedia : PlayMedia )
		{
			media = playMedia;
		}
					
		public function startPlayback( bufferTime : int, 
									   streamName : String, 
									   audio : Boolean,
									   video : Boolean ) : void
		{
			try 
			{
				// Check for reconnect.
				if ( nsPlay != null ) 
				{
					// Stop and close previous NetStream.
					var stopStreamCmd : StopStreamCommand = new StopStreamCommand(streamName);
					stopStreamCmd.dispatch();
				}
				// Setup NetStream for playback.
				nsPlay = new NetStream( modelLoc.netConnDelegate.connection );
				
				nsPlay.addEventListener( NetStatusEvent.NET_STATUS, netStatusEvent );
				nsPlay.addEventListener( IOErrorEvent.IO_ERROR, netIOError );
				nsPlay.addEventListener( AsyncErrorEvent.ASYNC_ERROR, netASyncError );
				
				nsPlay.bufferTime = bufferTime;
				nsPlay.receiveAudio( audio );
				nsPlay.receiveVideo( video );
				
				nsPlay.client = this;
				
				media.playState = PlaybackState.PLAYING;
				
				media.remoteVideo = new Video( model.defaultVideoSettings.width, 
						model.defaultVideoSettings.height );
				media.remoteVideo.attachNetStream( nsPlay );
				
				nsPlay.play( streamName );
				
			}
			catch( e : ArgumentError ) 
			{
				media.playState = PlaybackState.STOPPED;
				
				// Invalid parameters
				switch ( e.errorID ) 
				{
					// NetStream object must be connected.
					case 2126 :						
						//log.error( "StreamDelegate::Can't play stream, not connected to server");
						break;
					default :
					   break;
				}
			}
		}
		
		/**
		 * 
		 */		
		public function stopPlayback() : void
		{
			if ( nsPlay != null ) 
			{
				media.playState = PlaybackState.STOPPED;
				//log.warn("PlayMedia[" + media.streamName + "] stopped.");
				// Close the NetStream.
				nsPlay.close();
				if (media.remoteVideo != null) 
						media.remoteVideo = null;				
			}
		}
		
		/**
		 * Pause playback.
		 */		
		public function pausePlayback() : void
		{
			media.playState = PlaybackState.PAUSED;
			
			// Pause the NetStream.
			nsPlay.pause();
		}
		
		/**
		 * Resume playback.
		 */		
		public function resumePlayback() : void
		{
			media.playState = PlaybackState.PLAYING;
			
			// Resume playback for the NetStream.
			nsPlay.resume();
		}
		
		
		public function enableAudio( enable : Boolean ) : void
		{
			nsPlay.receiveAudio( enable );
		}
			
		public function enableVideo( enable : Boolean ) : void
		{
			
			nsPlay.receiveVideo( enable );
		}
					
		protected function netStatusEvent( event : NetStatusEvent ) : void 
		{
			handleResult( event );
		}
		
		protected function netSecurityError( event : SecurityErrorEvent ) : void 
		{
			handleFault( new SecurityErrorEvent ( SecurityErrorEvent.SECURITY_ERROR, false, true,
		    										  "Security error - " + event.text ) );
		}
			
		protected function netIOError( event : IOErrorEvent ) : void 
		{
			handleFault( new IOErrorEvent ( IOErrorEvent.IO_ERROR, false, true, 
							 "Input/output error - " + event.text ) );
		}
				
		protected function netASyncError( event : AsyncErrorEvent ) : void 
		{
			handleFault( new AsyncErrorEvent ( AsyncErrorEvent.ASYNC_ERROR, false, true,
							 "Asynchronous code error - <i>" + event.error + "</i>" ) );
		}

		public function handleResult(  event : Object  ) : void 
		{
			var info : Object = event.info;
			var statusCode : String = info.code;

			switch ( statusCode ) {
				case "NetStream.Play.Start" :
					// Start playback.
					playbackStarted();
					break;
					
				case "NetStream.Play.Stop":	
					playbackFinished = true;		
					break;
				
				case "NetStream.Buffer.Empty":	
					if ( playbackFinished ) 
					{
						// Playback stopped.
						playbackStopped();
					}	
					break;
				
				case "NetStream.Play.UnpublishNotify":
					// Playback stopped.
					playbackStopped();
					break;
					
				case "NetStream.Play.StreamNotFound":
					playbackStopped();
					break;
				
				case "NetStream.Pause.Notify":
					//log.info("NetStream.Pause.Notify for broadcast stream [" + media.streamName + "]");				
					break;
					
				case "NetStream.Unpause.Notify":
					//log.info("NetStream.Unpause.Notify for broadcast stream [" + media.streamName + "]");
					break;
					
				case "NetStream.Publish.Start":
					// Shouldn't be getting this since we are playing and NOT broadcasting
					//log.warn("NetStream.Publish.Start for broadcast stream [" + media.streamName + "]");
					break;
					
				case "NetStream.Publish.Idle":
				// Shouldn't be getting this since we are playing and NOT broadcasting
					//log.warn("NetStream.Publish.Idle for broadcast stream [" + media.streamName + "]");
					break;
					
				case "NetStream.Record.Failed":
				// Shouldn't be getting this since we are playing and NOT broadcasting
					//log.warn("NetStream.Record.Failed for broadcast stream [" + media.streamName + "]");
					break;
					
				case "NetStream.Record.Stop":
					//log.warn("NetStream.Record.Stop for broadcast stream [" + media.streamName + "]");
					break;
					
				case "NetStream.Record.Start":
					//log.warn("NetStream.Record.Start for broadcast stream [" + media.streamName + "]");
					break;
					
				case "NetStream.Unpublish.Success":
					//log.warn("NetStream.Unpublish.Success for broadcast stream [" + media.streamName + "]");;
					break;
					
				case "NetStream.Publish.BadName":
					//log.warn("NetStream.Publish.BadName for broadcast stream [" + media.streamName + "]");
					break;
			}
		}
				
		private function playbackStarted() : void
		{
			playbackFinished = false;
			media.playState = PlaybackState.PLAYING;
		}
							
		private function playbackStopped() : void
		{
			playbackFinished = false;
			media.playState = PlaybackState.STOPPED;
			if (media.remoteVideo != null) 
				media.remoteVideo = null;
		}
				
		public function handleFault(  event : Object  ) : void
		{			
			//log.error("BroadcastStreamDelegate::" + event.text );
			playbackStopped();
		}
			
		public function onPlayStatus( info : Object ) : void 
		{	
			//log.debug("BroadcastStreamDelegate::Playback - " + info.code  );
		}
			
		public function onMetaData ( info : Object ) : void 
		{
			for ( var d : String in info ) 
			{
				//log.info( "Metadata - " + d + ": " + info[ d ]);
			}
		}
					
		public function onCuePoint( info : Object ) : void 
		{
			for ( var d : String in info ) 
			{
				//log.info( "Cuepoint - " + d + ": " + info[ d ] );
			}
		}
		
    }
}