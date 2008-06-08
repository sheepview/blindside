package org.bigbluebutton.main.view
{
	import flexlib.mdi.containers.MDIWindow;
	
	import org.bigbluebutton.core.interfaces.InputPipe;
	import org.bigbluebutton.core.interfaces.OutputPipe;
	import org.bigbluebutton.core.interfaces.Router;
	import org.bigbluebutton.main.MainApplicationConstants;
	import org.bigbluebutton.main.view.components.MainApplicationShell;
	import org.bigbluebutton.modules.log.LogModule;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.PipeListener;
	
	public class MainApplicationShellMediator extends Mediator
	{
		public static const NAME:String = 'MainApplicationShellMediator';

		
		private var outpipe : OutputPipe;
		private var inpipe : InputPipe;
		public var router : Router;
		private var inpipeListener : PipeListener;
		private var logModule : LogModule;
		
		public function MainApplicationShellMediator( viewComponent:MainApplicationShell )
		{
			super( NAME, viewComponent );
			router = new Router(viewComponent);
			viewComponent.debugLog.text = "Log Module inited 1";
			inpipe = new InputPipe(MainApplicationConstants.TO_MAIN);
			outpipe = new OutputPipe(MainApplicationConstants.FROM_MAIN);
			inpipeListener = new PipeListener(this, messageReceiver);
			inpipe.connect(inpipeListener);
			router.registerOutputPipe(outpipe.name, outpipe);
			router.registerInputPipe(inpipe.name, inpipe);
			viewComponent.debugLog.text = "Log Module inited 1.5";
			
			logModule = new LogModule();
			viewComponent.debugLog.text = "Log Module inited 1.65";
			logModule.acceptRouter(router, viewComponent);
			viewComponent.debugLog.text = "Log Module inited 2";
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
					break;
				case MainApplicationConstants.REMOVE_WINDOW_MSG:
					window = message.getBody() as MDIWindow;
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