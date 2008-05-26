package org.blindsideproject.meetme.view
{
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class ListenersWindowMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ListenersWindowMediator";
		public static const UNMUTE_ALL:String = "Unmute All Users";
		public static const MUTE_ALL:String = "Mute All Users";
		
		public function ListenersWindowMediator(view:ListenersWindow)
		{
			super(NAME, view);
			view.addEventListener(UNMUTE_ALL, unmuteAllUsers);
			view.addEventListener(MUTE_ALL, muteAllUsers);
		}
		
		public function get listenersWindow():ListenersWindow{
			return viewComponent as ListenersWindow;
		}
		
		override public function listNotificationInterests():Array{
			return [];
		}
		
		override public function handleNotification(notification:INotification):void{
			
		}
		
		private function unmuteAllUsers(e:Event) : void
   		{
   			//var unmuteAllEvent : MuteAllUsersEvent = new MuteAllUsersEvent(false);
   			//unmuteAllEvent.dispatch();
   		}
   		
   		private function muteAllUsers() : void
   		{
   			//var muteAllEvent : MuteAllUsersEvent = new MuteAllUsersEvent(true);
   			//muteAllEvent.dispatch();
   		}

	}
}