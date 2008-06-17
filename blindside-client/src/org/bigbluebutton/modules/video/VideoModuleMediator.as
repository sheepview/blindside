package org.bigbluebutton.modules.video
{
	import org.bigbluebutton.common.InputPipe;
	import org.bigbluebutton.common.OutputPipe;
	import org.bigbluebutton.common.Router;
	import org.bigbluebutton.main.MainApplicationConstants;
	import org.bigbluebutton.modules.video.view.ViewCameraWindow;
	import org.bigbluebutton.modules.video.view.mediators.ViewCameraWindowMediator;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.PipeListener;
	
	public class VideoModuleMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "VideoModuleMediator";
		
		private var outpipe : OutputPipe;
		private var inpipe : InputPipe;
		private var router : Router;
		private var inpipeListener : PipeListener;
		
		private var videoWindow:ViewCameraWindow;
		
		public function VideoModuleMediator(module:VideoModule)
		{
			super(NAME, module);
			router = module.router;
			inpipe = new InputPipe(VideoConstants.TO_VIDEO_MODULE);
			outpipe = new OutputPipe(VideoConstants.FROM_VIDEO_MODULE);
			inpipeListener = new PipeListener(this, messageReceiver);
			router.registerOutputPipe(outpipe.name, outpipe);
			router.registerInputPipe(inpipe.name, inpipe);
			addVideoWindow();
		}
		
		private function messageReceiver(message:IPipeMessage):void{
			var msg:String = message.getHeader().MSG;
		}
		
		private function addVideoWindow():void{
			var msg:IPipeMessage = new Message(Message.NORMAL);
			msg.setHeader({MSG:MainApplicationConstants.ADD_WINDOW_MSG, SRC: VideoConstants.FROM_VIDEO_MODULE,
   						TO: MainApplicationConstants.TO_MAIN });
   			msg.setPriority(Message.PRIORITY_HIGH);
   			
   			videoWindow.width = 200;
   			videoWindow.height = 200;
   			videoWindow.title = ViewCameraWindow.TITLE;
   			msg.setBody(videoWindow);
   			outpipe.write(msg);
   			
		}
		
		override public function initializeNotifier(key:String):void{
			super.initializeNotifier(key);
			facade.registerMediator(new ViewCameraWindowMediator(videoWindow));
		}
		
		override public function listNotificationInterests():Array{
			return [];
		}
		
		override public function handleNotification(notification:INotification):void{
			
		}		

	}
}