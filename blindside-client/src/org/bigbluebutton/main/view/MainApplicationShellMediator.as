package org.bigbluebutton.main.view
{
	import flash.events.Event;
	import flash.system.Capabilities;
	
	import flexlib.mdi.containers.MDIWindow;
	
	import org.bigbluebutton.common.InputPipe;
	import org.bigbluebutton.common.OutputPipe;
	import org.bigbluebutton.common.Router;
	import org.bigbluebutton.main.MainApplicationConstants;
	import org.bigbluebutton.main.view.components.MainApplicationShell;
	import org.bigbluebutton.modules.chat.ChatModule;
	import org.bigbluebutton.modules.log.LogModule;
	import org.bigbluebutton.modules.presentation.PresentationModule;
	import org.bigbluebutton.modules.viewers.ViewersModule;
	import org.bigbluebutton.modules.voiceconference.VoiceModule;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.PipeListener;
	
/**
*   This is the Mediator class for MainApplicationShell view compom\nent
*/	
	public class MainApplicationShellMediator extends Mediator
	{
		public static const NAME:String = 'MainApplicationShellMediator';
		public static const OPEN_CHAT_MODULE:String = 'openChatModule';
		public static const OPEN_LOG_MODULE:String = 'openLogModule';

		private var xPos:Number;
		private var yPos:Number;
		
		private var outpipe : OutputPipe;
		private var inpipe : InputPipe;
		public var router : Router;
		private var inpipeListener : PipeListener;
		
		private var logModule : LogModule;
		private var chatModule : ChatModule;
		
		private var presentationModule:PresentationModule;
		private var voiceModule:VoiceModule;
		private var viewersModule:ViewersModule;

		/**
		 *  
		 * @param viewComponent:MainApplicationShell
		 * Constructor of class, initializing the router and pipes.
		 * Also starts the presentation and viewer modules 
		 */		
		public function MainApplicationShellMediator( viewComponent:MainApplicationShell )
		{
			super( NAME, viewComponent );
			router = new Router(viewComponent);
			///viewComponent.debugLog.text = "Log Module inited 1";
			viewComponent.addEventListener(OPEN_CHAT_MODULE , runChatModule);
			viewComponent.addEventListener(OPEN_LOG_MODULE , runLogModule);
			inpipe = new InputPipe(MainApplicationConstants.TO_MAIN);
			outpipe = new OutputPipe(MainApplicationConstants.FROM_MAIN);
			inpipeListener = new PipeListener(this, messageReceiver);
			inpipe.connect(inpipeListener);
			router.registerOutputPipe(outpipe.name, outpipe);
			router.registerInputPipe(inpipe.name, inpipe);
			
			logModule = new LogModule();
			logModule.acceptRouter(router, viewComponent);
			
			viewersModule = new ViewersModule();
			viewersModule.acceptRouter(router, viewComponent);
		
		}
		
		public function runPresentationModule():void{
			presentationModule = new PresentationModule();
			presentationModule.acceptRouter(router, shell);
		}
		
		public function runVoiceModule():void{
			voiceModule = new VoiceModule();
			voiceModule.acceptRouter(router, shell);
		}
		
		/**
		 * Runs the Chat Module 
		 * @param event
		 * 
		 */		
		public function runChatModule(event:Event) : void
		{
			chatModule = new ChatModule();
			chatModule.acceptRouter(router, shell);
		}
		/**
		 * Runs the Log Module 
		 * @param event
		 * 
		 */		
		public function runLogModule(event:Event) : void
		{
			
			//logModule = new LogModule();
			//logModule.acceptRouter(router, shell);
			
		}
		
		private function setLayout(window:MDIWindow):void{
			var screenX:Number = Capabilities.screenResolutionX;
			var screenY:Number = Capabilities.screenResolutionY;
			
			//var 
		}
		
		/**
		 * Handles the incoming messages through pipes to shell 
		 * @param message:IPipeMessage
		 * 
		 */		
		private function messageReceiver(message : IPipeMessage) : void
		{
			var msg : String = message.getHeader().MSG as String;
			var window : MDIWindow;
			
			shell.debugLog.text = "Got message: " + msg;
			
			switch (msg)
			{
				case MainApplicationConstants.ADD_WINDOW_MSG:
					window = message.getBody() as MDIWindow;
					//shell.mdiCanvas.windowManager.absPos(window, this.xPos, this.yPos);
					shell.mdiCanvas.windowManager.add(window);
					shell.mdiCanvas.windowManager.tile();
					break;
				case MainApplicationConstants.REMOVE_WINDOW_MSG:
					window = message.getBody() as MDIWindow;
					if(window.title == "Log") {
						shell.toolbar.LogBtn.enabled = true;
						window.visible = false;
					} else if(window.title == "Public Chat"){
						shell.toolbar.chatBtn.enabled = true;
						shell.mdiCanvas.windowManager.remove(window);
					} else shell.mdiCanvas.windowManager.remove(window);
					break;					
				case MainApplicationConstants.LOGIN_COMPLETE:
					runPresentationModule();
					runVoiceModule();
					break;				
			}
		}
		/**
		 * 
		 * @return : MainApplicationShell
		 * 
		 */				
		protected function get shell():MainApplicationShell
		{
			return viewComponent as MainApplicationShell;
		}
		
	}
}