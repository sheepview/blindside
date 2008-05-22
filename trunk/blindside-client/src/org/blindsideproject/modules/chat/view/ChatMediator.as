package org.blindsideproject.modules.chat.view
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class ChatMediator extends Mediator implements IMediator
	{
		public function ChatMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
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
			return null;
		}
		
		public function handleNotification(notification:INotification):void
		{
		}
		
		public function onRegister():void
		{
		}
		
		public function onRemove():void
		{
		}
		
	}
}