package org.bigbluebutton.modules.log.view
{
	import org.bigbluebutton.modules.log.LogApplicationFacade;
	import org.bigbluebutton.modules.log.view.components.LogModule;
	import org.bigbluebutton.modules.log.view.components.LogWindow;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;


	public class LogModuleMediator extends Mediator implements IMediator
	{
		public static const NAME:String = 'LogModuleMediator';
		
		private var logWindow : LogWindow = new LogWindow();
		
		public function LogModuleMediator( viewComponent:LogModule )
		{
			super( NAME, viewComponent );	
		}

		override public function initializeNotifier(key:String):void
		{
			super.initializeNotifier(key);
		} 
		
		override public function listNotificationInterests():Array
		{
			logModule.swidget.label = "listNotificationInterests";
			return [ LogApplicationFacade.MODULE_STARTED, 
					 LogApplicationFacade.REMOVE_WINDOW
			       ];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch ( note.getName() )
			{
				case LogApplicationFacade.MODULE_STARTED:
					logModule.swidget.label = "handleNotif";
					logWindow.width = 210;
					logWindow.height = 200;
					var addWindowMsg : IPipeMessage = new Message(LogApplicationFacade.ADD_WINDOW, null, logWindow);
					logModule.sendMessage(addWindowMsg);		
//					logModule.mbus.outputPipe().write(addWindowMsg);
					break;
					
				case LogApplicationFacade.REMOVE_WINDOW:
					var removeWindowMsg : IPipeMessage = new Message(LogApplicationFacade.REMOVE_WINDOW, null, logWindow);			
					logModule.mbus.outputPipe().write(removeWindowMsg);
					break;
			}
		}
		
		protected function get logModule():LogModule
		{
			return viewComponent as LogModule;
		}
	}
}