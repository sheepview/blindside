package org.bigbluebutton.modules.chat
{
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.interfaces.INotification;

	public class ChatFacade extends Facade implements IFacade
	{
		
		//public static const NAME:String = "ChatFacade";
		public static const STARTUP:String          = "startup";
		public static const NEW_MESSAGE:String      = "newMessage";
		
		public function ChatFacade(key:String)
		{
			super(key);
		}
		
		/**
		 * 
		 * @returns the instance of ChatFacade
		 * 
		 */
		public static function getInstance():ChatFacade{
			if (instanceMap[NAME] == null) instanceMap[NAME] = new ChatFacade();
			return instanceMap[NAME] as ChatFacade;
		
		}
		
		/**
		 * initializes the controller and registers the required commands with it 
		 * 
		 */
		override protected function initializeController():void{
			super.initializeController();
			registerCommand(STARTUP, StartupCommand);
			
		}
		
		public function startup(app:ChatWindow):void {
			
			sendNotification(ChatFacade.STARTUP, app);
		}
		
		public function registerProxy(proxy:IProxy):void
		{
		}
		
		public function retrieveProxy(proxyName:String):IProxy
		{
			return null;
		}
		
		public function sendNotification(notificationName:String, body:Object=null, type:String=null):void
		{
		}
		
		public function removeProxy(proxyName:String):IProxy
		{
			return null;
		}
		
		public function initializeNotifier(key:String):void
		{
		}
		
		public function hasProxy(proxyName:String):Boolean
		{
			return false;
		}
		
		public function registerCommand(noteName:String, commandClassRef:Class):void
		{
		}
		
		public function removeCommand(notificationName:String):void
		{
		}
		
		public function hasCommand(notificationName:String):Boolean
		{
			return false;
		}
		
		public function registerMediator(mediator:IMediator):void
		{
		}
		
		public function retrieveMediator(mediatorName:String):IMediator
		{
			return null;
		}
		
		public function removeMediator(mediatorName:String):IMediator
		{
			return null;
		}
		
		public function hasMediator(mediatorName:String):Boolean
		{
			return false;
		}
		
		public function notifyObservers(notification:INotification):void
		{
		}
		
		public function removeCore(key:String):void
		{
		}
		
	}
}