package org.blindsideproject.meetme.view
{
	import flash.events.Event;
	
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
	import org.blindsideproject.meetme.model.MeetMeFacade;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class ListenersWindowMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ListenersWindowMediator";
		public static const UNMUTE_ALL:String = "Unmute All Users";
		public static const MUTE_ALL:String = "Mute All Users";
		public static const EJECT_USER:String = "Eject User";
		
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		
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
			return [
					MeetMeFacade.USER_JOIN_EVENT
					];
		}
		
		override public function handleNotification(notification:INotification):void{
			switch(notification.getName()){
				case MeetMeFacade.USER_JOIN_EVENT:
					log.debug("Got Event Elsewhere");
					break;
			}
		}
		
		private function unmuteAllUsers(e:Event) : void
   		{
   			sendNotification(MeetMeFacade.MUTE_ALL_USERS_COMMAND, false);
   		}
   		
   		private function muteAllUsers(e:Event) : void
   		{
   			sendNotification(MeetMeFacade.MUTE_ALL_USERS_COMMAND, true);
   		}
   		
   		private function ejectUser(e:Event):void{
   			sendNotification(MeetMeFacade.EJECT_USER_COMMAND, listenersWindow.userid);
   		}

	}
}