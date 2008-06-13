package org.bigbluebutton.modules.viewers
{
	import org.bigbluebutton.common.InputPipe;
	import org.bigbluebutton.common.OutputPipe;
	import org.bigbluebutton.common.Router;
	import org.bigbluebutton.main.MainApplicationConstants;
	import org.bigbluebutton.modules.log.LogModule;
	import org.bigbluebutton.modules.log.LogModuleFacade;
	import org.bigbluebutton.modules.viewers.view.JoinWindow;
	import org.bigbluebutton.modules.viewers.view.ViewersWindow;
	import org.bigbluebutton.modules.viewers.view.mediators.JoinWindowMediator;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.PipeListener;
	
	public class ViewersModuleMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ViewersModuleMediator";
		
		private var outpipe : OutputPipe;
		private var inpipe : InputPipe;
		private var router : Router;
		private var inpipeListener : PipeListener;
		
		private var joinWindow:JoinWindow;
		private var viewersWindow:ViewersWindow;
		
		private var log:LogModuleFacade = LogModuleFacade.getInstance(LogModule.NAME);
		
		public function ViewersModuleMediator(module:ViewersModule)
		{
			super(NAME, module);
			router = module.router;
			inpipe = new InputPipe(ViewersConstants.TO_VIEWERS_MODULE);
			outpipe = new OutputPipe(ViewersConstants.FROM_VIEWERS_MODULE);
			inpipeListener = new PipeListener(this, messageReceiver);
			router.registerOutputPipe(outpipe.name, outpipe);
			router.registerInputPipe(inpipe.name, inpipe);
			addJoinWindow();
		}
		
		private function messageReceiver(message:IPipeMessage):void{
			var msg:String = message.getHeader().MSG;
		}
		
		private function addJoinWindow():void{
			var msg:IPipeMessage = new Message(Message.NORMAL);
			msg.setHeader({MSG:MainApplicationConstants.ADD_WINDOW_MSG, SRC: ViewersConstants.FROM_VIEWERS_MODULE,
   						TO: MainApplicationConstants.TO_MAIN });
   			msg.setPriority(Message.PRIORITY_HIGH);
   			
   			joinWindow = new JoinWindow();
   			joinWindow.showCloseButton = false;
   			msg.setBody(joinWindow);
   			outpipe.write(msg);
		}
		
		private function addViewersWindow():void{
			var msg:IPipeMessage = new Message(Message.NORMAL);
			msg.setHeader({MSG:MainApplicationConstants.ADD_WINDOW_MSG, SRC: ViewersConstants.FROM_VIEWERS_MODULE,
   						TO: MainApplicationConstants.TO_MAIN });
   			msg.setPriority(Message.PRIORITY_HIGH);
   			
   			viewersWindow = new ViewersWindow();
   			viewersWindow.width = 210;
   			viewersWindow.height = 220;
   			viewersWindow.title = "Viewers";
   			viewersWindow.showCloseButton = false;
   			msg.setBody(viewersWindow);
   			outpipe.write(msg);
   			sendNotification(ViewersFacade.START_VIEWER_WINDOW, viewersWindow);
		}
		
		private function removeJoinWindow():void{
			var msg:IPipeMessage = new Message(Message.NORMAL);
			msg.setHeader({MSG:MainApplicationConstants.REMOVE_WINDOW_MSG, SRC: ViewersConstants.FROM_VIEWERS_MODULE,
   						TO: MainApplicationConstants.TO_MAIN });
   			msg.setPriority(Message.PRIORITY_HIGH);
   			
   			msg.setBody(joinWindow);
   			outpipe.write(msg);
		}
		
		override public function initializeNotifier(key:String):void{
			super.initializeNotifier(key);
			//facade.registerMediator(new JoinWindowMediator(joinWindow));
			sendNotification(ViewersFacade.START_LOGIN_WINDOW, joinWindow);
		}
		
		override public function listNotificationInterests():Array{
			return [
					ViewersFacade.CONNECT_SUCCESS,
					ViewersFacade.DEBUG
					];
		}
		
		override public function handleNotification(notification:INotification):void{
			switch(notification.getName()){
				case ViewersFacade.CONNECT_SUCCESS:
					removeJoinWindow();
					addViewersWindow();
					break;
				case ViewersFacade.DEBUG:
					log.debug(notification.getBody() as String);
					break;
			}
		}

	}
}