package view
{
	import flash.events.Event;
	
	import model.DrawProxy;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * The mediator class for the Board GUI component.
	 * <p>
	 * This class extends the Mediator class of the PureMVC framework
	 * @author dzgonjan
	 * 
	 */	
	public class BoardMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "BoardMediator";
		//private var board:Board;
		
		/**
		 * The constructor. Calls the super constructor and registers the event listener to listen for updates
		 * coming from the Board GUI component. 
		 * @param view The Board component
		 * 
		 */		
		public function BoardMediator(view:Board):void
		{
			super(NAME, view);
			board.addEventListener(Board.SEND_SHAPE, sendUpdate);
		}
		
		/**
		 * Returns the Board GUI component that is registered to this Mediator object 
		 * @return 
		 * 
		 */		
		protected function get board():Board{
			return viewComponent as Board;
		}
		
		/**
		 * Once an event is received from the board component, the sendUpdate method calls the DrawProxy, sending
		 * to it the shape that has just been drawn on the screen 
		 * @param e The received event from the Board
		 * 
		 */		
		protected function sendUpdate(e:Event):void{
			var drawProxy:DrawProxy;
			drawProxy = facade.retrieveProxy(DrawProxy.NAME) as DrawProxy;
			drawProxy.sendShape(this.board.d);
		}
		
		/**
		 * An override method that lists which notifications this class is interested in
		 * <p>
		 * This class listens to:
		 *		- BoardFacade.UPDATE 
		 * 		- BoardFacade.FAILED_CONNECTION
		 * @return An array of strings representing all the notifications being listened to
		 * 
		 */		
		override public function listNotificationInterests():Array{
			return [
					BoardFacade.UPDATE,
					BoardFacade.FAILED_CONNECTION
				   ];
		}
		
		/**
		 * An override method that handles the Notification sent by other parts of the application 
		 * <p>
		 * If the BoardMediator is notified that a connection to Red5 is interupted at any point it
		 * will disable the whiteboard.
		 * @param notification The notification that was sent by another part of the application
		 * 
		 */		
		override public function handleNotification(notification:INotification):void{
			switch(notification.getName())
			{
				case BoardFacade.UPDATE:
					this.board.drawSegment();	
					break;
				
				case BoardFacade.FAILED_CONNECTION:
					this.board.enabled = false;
					break;
			}
		}

	}
}