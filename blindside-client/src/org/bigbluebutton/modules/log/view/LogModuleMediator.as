package org.bigbluebutton.modules.log.view
{
	import org.bigbluebutton.common.InputPipe;
	import org.bigbluebutton.common.OutputPipe;
	import org.bigbluebutton.common.Router;
	import org.bigbluebutton.main.MainApplicationConstants;
	import org.bigbluebutton.modules.log.LogModuleFacade;
	import org.bigbluebutton.modules.log.LogModule;
	import org.bigbluebutton.modules.log.LogModuleConstants;
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

		private var outpipe : OutputPipe;
		private var inpipe : InputPipe;
		private var router : Router;
		private var inpipeListener : PipeListener;
				
		private var logWindow : LogWindow = new LogWindow();
		
		public function LogModuleMediator( viewComponent:LogModule )
		{
			super( NAME, viewComponent );	
			viewComponent.mshell.debugLog.text = "in logmodule mediator";
			
			router = viewComponent.router;
			inpipe = new InputPipe(LogModuleConstants.TO_LOG_MODULE);
			outpipe = new OutputPipe(LogModuleConstants.FROM_LOG_MODULE);
			inpipeListener = new PipeListener(this, messageReceiver);
			router.registerOutputPipe(outpipe.name, outpipe);
			router.registerInputPipe(inpipe.name, inpipe);
			viewComponent.mshell.debugLog.text = "in logmodule mediator 2";
			addWindow();
		}

		override public function initializeNotifier(key:String):void
		{
			super.initializeNotifier(key);
		} 
		
//		override public function listNotificationInterests():Array
//		{
//			return [ LogModuleFacade., 
//					 LogModuleFacade.REMOVE_WINDOW
//			       ];
//		}
		
		override public function handleNotification(note:INotification):void
		{
			switch ( note.getName() )
			{
				case 1:

					break;
					
				case 2:

					break;
			}
		}
		
		private function addWindow() : void
		{
			// create a message
   			var msg:IPipeMessage = new Message(Message.NORMAL);
   			msg.setHeader( {MSG:MainApplicationConstants.ADD_WINDOW_MSG, SRC: LogModuleConstants.FROM_LOG_MODULE,
   						TO: MainApplicationConstants.TO_MAIN });
   			msg.setPriority(Message.PRIORITY_HIGH );
   			
			logWindow.width = 210;
			logWindow.height = 200;
			logWindow.title = "Log";
			msg.setBody(logWindow);
			viewComponent.mshell.debugLog.text = "in logmodule mediator addwindow";
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