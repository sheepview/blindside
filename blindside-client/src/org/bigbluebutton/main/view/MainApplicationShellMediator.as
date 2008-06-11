package org.bigbluebutton.main.view
{
	import flash.events.Event;
	
	import flexlib.mdi.containers.MDIWindow;
	
	import org.bigbluebutton.common.InputPipe;
	import org.bigbluebutton.common.OutputPipe;
	import org.bigbluebutton.common.Router;
	import org.bigbluebutton.main.MainApplicationConstants;
	import org.bigbluebutton.main.view.components.MainApplicationShell;
	import org.bigbluebutton.modules.chat.ChatModule;
	import org.bigbluebutton.modules.log.LogModule;
	import org.bigbluebutton.modules.presentation.PresentationModule;
	import org.bigbluebutton.modules.voiceconference.VoiceModule;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.PipeListener;
	
	public class MainApplicationShellMediator extends Mediator
	{
		public static const NAME:String = 'MainApplicationShellMediator';
		public static const OPEN_CHAT_MODULE:String = 'openChatModule';
		public static const OPEN_LOG_MODULE:String = 'openLogModule';

		
		private var outpipe : OutputPipe;
		private var inpipe : InputPipe;
		public var router : Router;
		private var inpipeListener : PipeListener;
		
		private var logModule : LogModule;
		private var chatModule : ChatModule;
		
		private var presentationModule:PresentationModule;
		private var voiceModule:VoiceModule;
		
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
			//viewComponent.debugLog.text = "Log Module inited 1.5";
			
			//logModule = new LogModule();
						
			//viewComponent.debugLog.text = "Log Module inited 1.65";
			//logModule.acceptRouter(router, viewComponent);
			//viewComponent.debugLog.text = "Log Module inited 2";
			
			presentationModule = new PresentationModule();
			presentationModule.acceptRouter(router, viewComponent);
			
			voiceModule = new VoiceModule();
			voiceModule.acceptRouter(router, viewComponent);
		
		}
		
		public function runChatModule(event:Event) : void
		{
			chatModule = new ChatModule();
			chatModule.acceptRouter(router, shell);
		}
		
		public function runLogModule(event:Event) : void
		{
			logModule = new LogModule();
			logModule.acceptRouter(router, shell);
		}
		private function messageReceiver(message : IPipeMessage) : void
		{
			var msg : String = message.getHeader().MSG as String;
			var window : MDIWindow;
			shell.debugLog.text = "Got message: " + msg;
			
			switch (msg)
			{
				case MainApplicationConstants.ADD_WINDOW_MSG:
					window = message.getBody() as MDIWindow;
					shell.mdiCanvas.windowManager.add(window);
					shell.mdiCanvas.windowManager.absPos(window, 20, 250);
					if(window.title == "Log") shell.toolbar.LogBtn.enabled = false;
					if(window.title == "Public Chat") shell.toolbar.chatBtn.enabled = false;
					break;
				case MainApplicationConstants.REMOVE_WINDOW_MSG:
					window = message.getBody() as MDIWindow;
					if(window.title == "Log") shell.toolbar.LogBtn.enabled = true;
					if(window.title == "Public Chat") shell.toolbar.chatBtn.enabled = true;
					shell.mdiCanvas.windowManager.remove(window);
					
					break;									
			}
		}
				
		protected function get shell():MainApplicationShell
		{
			return viewComponent as MainApplicationShell;
		}
		
	}
}