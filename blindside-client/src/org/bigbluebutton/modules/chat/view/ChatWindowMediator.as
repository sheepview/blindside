package org.bigbluebutton.modules.chat.view
{
	import flash.events.Event;
	
	import org.bigbluebutton.modules.chat.ChatFacade;
	import org.bigbluebutton.modules.chat.model.business.ChatProxy;
	import org.bigbluebutton.modules.chat.model.vo.*;
	import org.bigbluebutton.modules.chat.view.components.ChatWindow;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class ChatWindowMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ChatMediator";
		public static const NEW_MESSAGE:String = "newMessage";
		
		public function ChatWindowMediator(viewComponent:ChatWindow)
		{
			super(NAME, viewComponent);
			viewComponent.addEventListener(ChatWindowMediator.NEW_MESSAGE, sendNewMessage);
		}
		
		
		protected function get chatWindow():ChatWindow{
			return viewComponent as ChatWindow;
		}
		
		public function sendNewMessage(e:Event):void
		{
			proxy.sendMessageToSharedObject(chatWindow.m);
			
		}
		
		
		
		
		
		override public function listNotificationInterests():Array
		{
			return [
					ChatFacade.NEW_MESSAGE
				   ];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ChatFacade.NEW_MESSAGE:
					this.chatWindow.showNewMessage(notification.getBody() as MessageObject);
					break;	
			}
		}
		
		public function get proxy():ChatProxy{
			return facade.retrieveProxy(ChatProxy.NAME) as ChatProxy;
		} 
		
		
		
		
	}
}