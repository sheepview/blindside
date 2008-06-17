package org.red5.samples.publisher
{
	import flash.net.ObjectEncoding;
	
	import org.bigbluebutton.modules.video.VideoFacade;
	import org.bigbluebutton.modules.video.control.notifiers.PlayStreamNotifier;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.red5.samples.publisher.control.commands.*;
	import org.red5.samples.publisher.model.*;
	import org.red5.samples.publisher.vo.settings.*;
	
	public class PublisherApplicationMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "PublisherApplicationMediator";
		
		private var modelLoc : PublisherModelLocator = PublisherModelLocator.getInstance();
		private var log : ILogger = LoggerModelLocator.getInstance().log;

		private var model : PublisherModel = PublisherModelLocator.getInstance().model;
						
		public function PublisherApplicationMediator() {
			super(NAME);
		}
		
		override public function listNotificationInterests():Array{
			return [
					];
		}
		
		override public function handleNotification(notification:INotification):void{
			switch(notification.getName()){
				case VideoFacade.PAUSE_STREAM_COMMAND:
					pauseStream(notification.getBody() as String);
					break;
				case VideoFacade.PLAY_STREAM_COMMAND:
					var note:PlayStreamNotifier = notification.getBody() as PlayStreamNotifier;
					playStream(note.streamName, note.enableVideo, note.enableAudio);
					break;
				case VideoFacade.RESUME_STREAM_COMMAND:
					resumeStream(notification.getBody() as String);
					break;
				case VideoFacade.STOP_STREAM_COMMAND:
					stopStream(notification.getBody() as String);
					break;
					
			}
		}
		
		public function createBroadcastMedia(streamName : String) : void
		{
			model.createBroadcastMedia(streamName);
		}

		public function createPlayMedia(streamName : String) : void
		{
			model.createPlayMedia(streamName);
		}
				
		public function getBroadcastMedia(streamName : String) : IMedia
		{
			return model.getBroadcastMedia(streamName);
		}

		public function getPlayMedia(streamName : String) : IMedia
		{
			return model.getPlayMedia(streamName);
		}
				
		public function connect(host : String) : void
		{
			var encodingType : uint = ObjectEncoding.AMF0;
			var proxyType : String = "none";
			var serverType : int = 0; // Red5

			model.generalSettings = new GeneralSettings( host,
														serverType,
														encodingType,
														0 /*"none"*/ );
			
			log.debug("Publisher connecting to <b>" + host + "</b>");
			
			var startConnectionCommand : StartConnectionCommand 
					= new StartConnectionCommand( host,
											proxyType,
											encodingType);
																							
			startConnectionCommand.dispatch();
		}
		
		public function disconnect() : void
		{
			var closeCmd : CloseConnectionCommand = new CloseConnectionCommand();
			closeCmd.dispatch();			
		}
		
		public function setupDevices() : void
		{
			var devicesCmd : SetupDevicesCommand = new SetupDevicesCommand();
			devicesCmd.dispatch();			
		}
		
		public function setupConnection() : void
		{
			var connectionCmd : SetupConnectionCommand = new SetupConnectionCommand();
			connectionCmd.dispatch();			
		}
		
		public function setupStream(streamName : String) : void
		{
			var streamsCmd : SetupStreamsCommand = new SetupStreamsCommand(streamName);
			streamsCmd.dispatch();			
		}

		public function stopCamera(streamName : String) : void
		{
			var stopCameraCmd : StopCameraCommand = new StopCameraCommand(streamName);
			stopCameraCmd.dispatch();			
		}
		
		public function startCamera(streamName : String) : void
		{						
			var startCameraCmd : StartCameraCommand 
						= new StartCameraCommand( streamName);
				startCameraCmd.dispatch();			

		}
		
		public function startMicrophone(streamName : String) : void
		{
			var startMicrophoneCmd : StartMicrophoneCommand 
						= new StartMicrophoneCommand( streamName );
			startMicrophoneCmd.dispatch();						

		}
		
		public function stopMicrophone(streamName : String) : void
		{
			var stopMicrophoneCmd : StopMicrophoneCommand = new StopMicrophoneCommand(streamName);
			stopMicrophoneCmd.dispatch();			
		}
		
		/**
		 * Broadcast a stream to other users.
		 * 
		 * @param publishMode Can be [live, record, append]
		 * @param streamName the name of the stream to bradcast
		 */		
		public function startBroadcasting(publishMode : String, streamName : String) : void
		{
			log.debug("Start broadcasting[" + publishMode + "," + streamName + "]");
			
			var publishStreamCmd : PublishStreamCommand = new PublishStreamCommand( publishMode, streamName );
			publishStreamCmd.dispatch();			
		}
		
		public function stopBroadcasting(streamName : String) : void
		{
			var unpublishStreamCmd : UnpublishStreamCommand = new UnpublishStreamCommand(streamName);
			unpublishStreamCmd.dispatch();			
		}
		
		public function pauseStream(streamName : String) : void
		{
			// Pause playback.
			var pauseStreamCmd : PauseStreamCommand = new PauseStreamCommand(streamName);
			pauseStreamCmd.dispatch();			
		}
		
		public function playStream(streamName : String, enableVideo : Boolean, enableAudio : Boolean) : void
		{
			// Start playback from beginning.
			var playStreamCmd : PlayStreamCommand
					= new PlayStreamCommand( streamName,
										 enableVideo,
										 enableAudio );	
			playStreamCmd.dispatch();		
		}	
		
		public function resumeStream(streamName : String) : void
		{
			// Resume playback.
			var resumeStreamCmd : ResumeStreamCommand = new ResumeStreamCommand(streamName);
			resumeStreamCmd.dispatch(); 			
		}		
		
		public function stopStream(streamName : String) : void
		{	
			// Stop playback and close stream.
			var stopStreamCmd : StopStreamCommand = new StopStreamCommand(streamName);
			stopStreamCmd.dispatch();			
		}	
		
		public function enableAudio(streamName : String, enableAudio : Boolean) : void
		{
			var toggleAudioCmd : EnableAudioCommand = new EnableAudioCommand(streamName, enableAudio );
			toggleAudioCmd.dispatch();			
		}	

		public function enableVideo(streamName : String, enableVideo : Boolean) : void
		{
			var toggleVideoCmd : EnableVideoCommand = new EnableVideoCommand(streamName, enableVideo );
			toggleVideoCmd.dispatch();			
		}
	}
}