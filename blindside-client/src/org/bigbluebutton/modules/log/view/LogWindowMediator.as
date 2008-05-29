package org.bigbluebutton.modules.log.view
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class LogWindowMediator extends Mediator implements IMediator
	{
		
		public static const LOG_MESSAGE:String = "logMessage";
		
		public function LogWindowMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
			viewComponent.addEventListener(LogWindowMediator.LOG_MESSAGE, onLogMessage);
		}
		
		protected function get logWindow():LogWindow{
			return viewComponent as LogWindow;
		}
		
		public function onLogMessage():void
		{
			proxy.sendMessageToSharedObject(this.getViewComponent().logMessage);
		}
		
		
		public function sendNotification(notificationName:String, body:Object=null, type:String=null):void
		{
		}
		
		public function initializeNotifier(key:String):void
		{
		}
		
		public function getMediatorName():String
		{
			return null;
		}
		
		public function getViewComponent():Object
		{
			return null;
		}
		
		public function setViewComponent(viewComponent:Object):void
		{
		}
		
		public function listNotificationInterests():Array
		{
			return [
					LogFacade.UPDATE
				   ];
		}
		
		public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case LogFacade.LOG_MESSAGE:
					this.getViewComponent().updateDisplay(notification.getBody() as MessageObject);
					break;	
			}
		}
		
		public function onRegister():void
		{
		}
		
		public function onRemove():void
		{
		}
		
	}
}