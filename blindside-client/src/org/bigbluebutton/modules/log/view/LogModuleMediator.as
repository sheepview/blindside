package org.bigbluebutton.modules.log.view
{
	import org.bigbluebutton.core.interfaces.InputPipe;
	import org.bigbluebutton.core.interfaces.OutputPipe;
	import org.bigbluebutton.core.interfaces.Router;
	import org.bigbluebutton.modules.log.LogApplicationFacade;
	import org.bigbluebutton.modules.log.LogModule;
	import org.bigbluebutton.modules.log.view.components.LogWindow;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.PipeListener;


	public class LogModuleMediator extends Mediator implements IMediator
	{
		public static const NAME:String = 'LogModuleMediator';
		public static const LOG_OUTPIPE:String = 'LOG_OUTPIPE';
		public static const LOG_INPIPE:String = 'LOG_INPIPE';
		
		private var outpipe : OutputPipe;
		private var inpipe : InputPipe;
		private var router : Router;
		private var inpipeListener : PipeListener;
				
		private var logWindow : LogWindow = new LogWindow();
		
		public function LogModuleMediator( viewComponent:LogModule )
		{
			super( NAME, viewComponent );	
			viewComponent.mshell.loginWindow.title = "in logmodule mediator";
			
			router = viewComponent.router;
			inpipe = new InputPipe(LOG_INPIPE);
			outpipe = new OutputPipe(LOG_OUTPIPE);
			inpipeListener = new PipeListener(this, messageReceiver);
			router.registerOutputPipe(outpipe.name, outpipe);
			router.registerInputPipe(inpipe.name, inpipe);
			viewComponent.mshell.loginWindow.title = "in logmodule mediator 2";
			addWindow();
		}

		override public function initializeNotifier(key:String):void
		{
			super.initializeNotifier(key);
		} 
		
		override public function listNotificationInterests():Array
		{
			return [ LogApplicationFacade.MODULE_STARTED, 
					 LogApplicationFacade.REMOVE_WINDOW
			       ];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch ( note.getName() )
			{
				case LogApplicationFacade.MODULE_STARTED:
					logWindow.width = 210;
					logWindow.height = 200;
					var addWindowMsg : IPipeMessage = new Message(LogApplicationFacade.ADD_WINDOW, null, logWindow);
					//logModule.sendMessage(addWindowMsg);		
//					logModule.mbus.outputPipe().write(addWindowMsg);
					break;
					
				case LogApplicationFacade.REMOVE_WINDOW:
					var removeWindowMsg : IPipeMessage = new Message(LogApplicationFacade.REMOVE_WINDOW, null, logWindow);			
					//logModule.mbus.outputPipe().write(removeWindowMsg);
					break;
			}
		}
		
		private function addWindow() : void
		{
			// create a message
   			var msg:IPipeMessage = new Message(Message.NORMAL);
   			msg.setHeader( {MSG:'ADD_WINDOW', SRC:LOG_OUTPIPE, TO: 'SHELL_INPIPE' });
   			msg.setPriority(Message.PRIORITY_HIGH );
   			
			logWindow.width = 210;
			logWindow.height = 200;
			msg.setBody(logWindow);
			viewComponent.mshell.loginWindow.title = "in logmodule mediator addwindow";
			outpipe.write(msg);			
		}
		
		protected function get logModule():LogModule
		{
			return viewComponent as LogModule;
		}

		private function messageReceiver(message : IPipeMessage) : void
		{
			var msg : String = message.getHeader().MSG;
//			var window : MDIWindow;
			
//			switch (msg)
//			{
//				case Messages.ADD_WINDOW:
//					window = message.getBody() as MDIWindow;
//					shell.mdiCanvas.windowManager.add(window);
//					shell.mdiCanvas.windowManager.absPos(window, 20, 250);	
//					break;
//				case Messages.REMOVE_WINDOW:
//					window = message.getBody() as MDIWindow;
//					shell.mdiCanvas.windowManager.remove(window);
//					break;									
//			}
		}
	}
}