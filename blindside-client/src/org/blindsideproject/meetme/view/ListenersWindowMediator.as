package org.blindsideproject.meetme.view
{
	import flash.events.Event;
	
	import org.blindsideproject.meetme.model.MeetMeModelLocator;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class ListenersWindowMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ListenersWindowMediator";
		public static const UNMUTE_ALL:String = "Unmute All Users";
		public static const MUTE_ALL:String = "Mute All Users";
		public static const EJECT_USER:String = "Eject User";
		
		public function ListenersWindowMediator(view:ListenersWindow)
		{
			super(NAME, view);
			view.addEventListener(UNMUTE_ALL, unmuteAllUsers);
			view.addEventListener(MUTE_ALL, muteAllUsers);
			view.addEventListener(EJECT_USER, ejectUser);
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
   			sendNotification(MeetMeModelLocator.MUTE_ALL_USERS_COMMAND, false);
   		}
   		
   		private function muteAllUsers() : void
   		{
   			sendNotification(MeetMeModelLocator.MUTE_ALL_USERS_COMMAND, true);
   		}
   		
   		private function ejectUser():void{
   			sendNotification(MeetMeModelLocator.EJECT_USER_COMMAND, listenersWindow.userid);
   		}

	}
}