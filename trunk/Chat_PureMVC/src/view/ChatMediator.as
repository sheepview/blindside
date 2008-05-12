package chat.view
{
	import flash.events.Event;

	
	import chat.model.*;
	import chat.ChatFacade;
	import chat.view.ApplicationMediator;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	/**
	 * ChatMediator  
	 * @author snegari
	 * 
	 */	
	public class ChatMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ChatMediator";
		public static const SEND_MESSAGE:String = "sendMessage";
		
		/**
		 * Event listeners are added to view component in constructor
		 * @param view
		 * 
		 */		
		public function ChatMediator(view:Chat):void
		{
			super(NAME, view);
			view.addEventListener(ChatMediator.SEND_MESSAGE, sendUpdate);
		}
		
		/**
		 * get method that returns the view component
		 * @return view component Chat
		 * 
		 */		
		protected function get chat():Chat{
			return viewComponent as Chat;
		}
		
		/**
		 * 
		 * @param e: The event that has update information
		 * 
		 */			
		protected function sendUpdate(e:Event):void{
			proxy.sendMessage(this.getViewComponent().m);
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
					ChatFacade.UPDATE
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
				case ChatFacade.UPDATE:
					this.getViewComponent().sendChatMessage(notification.getBody() as MessageObject);
					break;	
			}
		}
		/**
		 * A get method to retrieve required proxy 
		 * @return MessageProxy
		 * 
		 */		
		public function get proxy():MessageProxy{
			return facade.retrieveProxy(MessageProxy.NAME) as MessageProxy;
		}

	}
}