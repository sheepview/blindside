package view
{
	import flash.events.Event;
	
	import model.*;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	
	public class ChatMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ChatMediator";
		public static const SEND_MESSAGE:String = "sendMessage";
		
		
		public function ChatMediator(view:Chat):void
		{
			super(NAME, view);
			chat.addEventListener(ChatMediator.SEND_MESSAGE, sendUpdate);
		}
		
		
		protected function get chat():Chat{
			return viewComponent as Chat;
		}
		
			
		protected function sendUpdate(e:Event):void{
			proxy.sendMessage(this.chat.m);
		}
		
		/**
		 * An override method that lists which notifications this class is interested in
		 * <p>
		 * This class listens to:
		 *		- BoardFacade.UPDATE 
		 * @return An array of strings representing all the notifications being listened to
		 * 
		 */		
		override public function listNotificationInterests():Array{
			return [
					ApplicationFacade.UPDATE
				   ];
		}
		
		/**
		 * An override method that handles the Notification sent by other parts of the application 
		 * @param notification The notification that was sent by another part of the application
		 * 
		 */		
		override public function handleNotification(notification:INotification):void{
			switch(notification.getName())
			{
				case ApplicationFacade.UPDATE:
					this.chat.sendChatMessage(notification.getBody() as MessageObject);
					break;	
			}
		}
		
		public function get proxy():MessageProxy{
			return facade.retrieveProxy(MessageProxy.NAME) as MessageProxy;
		}

	}
}