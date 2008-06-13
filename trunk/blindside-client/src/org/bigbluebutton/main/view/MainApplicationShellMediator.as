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
/**
*   This is the Mediator class for MainApplicationShell view compom\nent
*/	
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
			
			presentationModule = new PresentationModule();
			presentationModule.acceptRouter(router, viewComponent);
			
			voiceModule = new VoiceModule();
			voiceModule.acceptRouter(router, viewComponent);
		
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
					
					if(window.title == "Log"){
						shell.toolbar.LogBtn.enabled = false;
						shell.mdiCanvas.windowManager.absPos(window, 20, 450);
						shell.mdiCanvas.windowManager.add(window);
						//window.visible = true;	
					} 
					else if(window.title == "Public Chat"){
						shell.toolbar.chatBtn.enabled = false;
						shell.mdiCanvas.windowManager.absPos(window, 800, 20);
						shell.mdiCanvas.windowManager.add(window);
					} 
					else if(window.title == "Presentation"){
						shell.mdiCanvas.windowManager.absPos(window, 300, 20);
						shell.mdiCanvas.windowManager.add(window);
					} 
					else if(window.title == "Listeners"){
						shell.mdiCanvas.windowManager.absPos(window, 20, 20);
						shell.mdiCanvas.windowManager.add(window);
					} 
					break;
				case MainApplicationConstants.REMOVE_WINDOW_MSG:
					window = message.getBody() as MDIWindow;
					
					if(window.title == "Log") {
						shell.toolbar.LogBtn.enabled = true;
						window.visible = false
					}
					
					else if(window.title == "Public Chat"){
						shell.toolbar.chatBtn.enabled = true;
						shell.mdiCanvas.windowManager.remove(window);
					} 
					
					else shell.mdiCanvas.windowManager.remove(window);
					
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