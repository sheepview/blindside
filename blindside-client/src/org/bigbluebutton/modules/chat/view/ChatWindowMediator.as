package org.bigbluebutton.modules.chat.view
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class ChatWindowMediator extends Mediator implements IMediator
	{
		
		public static const NEW_MESSAGE:String = "newMessage";
		
		public function ChatWindowMediator(mediatorName:String=null, viewComponent:ChatWindow)
		{
			super(mediatorName, viewComponent);
			viewComponent.addEventListener(ChatWindowMediator.NEW_MESSAGE, sendNewMessage);
		}
		
		
		protected function get chatWindow():ChatWindow{
			return viewComponent as ChatWindow;
		}
		
		public function sendNewMessage():void
		{
			proxy.sendMessageToSharedObject(this.getViewComponent().newMessage);
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
					ChatFacade.UPDATE
				   ];
		}
		
		public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ChatFacade.NEW_MESSAGE:
					this.getViewComponent().showNewMessage(notification.getBody() as MessageObject);
					break;	
			}
		}
		
		public function get proxy():ChatProxy{
			return facade.retrieveProxy(ChatProxy.NAME) as ChatProxy;
		} 
		
		public function onRegister():void
		{
		}
		
		public function onRemove():void
		{
		}
		
	}
}