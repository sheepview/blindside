package org.blindsideproject.meetme.view
{
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
	import org.blindsideproject.meetme.control.notifiers.MuteNotifier;
	import org.blindsideproject.meetme.model.MeetMeFacade;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class MeetMeUserItemMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "MeetMeUserItemMediator";
		public static const MUTE_UNMUTE_USER:String = "Mute-Unmute User";
		
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		
		public function MeetMeUserItemMediator(view:MeetMeUserItem)
		{
			log.debug("MeetMeUserMediator");
			super(NAME, view);
			view.addEventListener(MUTE_UNMUTE_USER, muteUnmuteUser);
		}
		
		public function get meetMeUserItem():MeetMeUserItem{
			return viewComponent as MeetMeUserItem;
		}
		
		override public function listNotificationInterests():Array{
			return [
					MeetMeFacade.USER_JOIN_EVENT
					];
		}
		
		override public function handleNotification(notification:INotification):void{
			switch(notification.getName()){
				case MeetMeFacade.USER_JOIN_EVENT:
					onNewMeetMeEvent(notification);
					break;
			}
		}
		
		private function muteUnmuteUser() : void
   		{
   			if (! meetMeUserItem.isModerator) return;
   			
   			//var muteEvent : MuteUnmuteUserEvent = new MuteUnmuteUserEvent(data.userid, !data.isMuted);
   			//muteEvent.dispatch();
   			sendNotification(MeetMeFacade.MUTE_EVENT, new MuteNotifier(meetMeUserItem.data.userid, !meetMeUserItem.data.isMuted));
   			
   			log.debug("MeetMeUserItem::muteUnmuteUser : [" + meetMeUserItem.data.userid + "," + !meetMeUserItem.data.isMuted + "]");
   		}
   		
   		private function onNewMeetMeEvent(note:INotification) : void
   		{
   			//var statusEvent : NewMeetMeEvent = NewMeetMeEvent(event);
   				
   			log.debug("Got newMeetMeEvent."); // comment out as generates too much noise

   			meetMeUserItem.displayStatusIcon();	
   		}
   		
   		private function ejectUser() : void
   		{
   			if (! meetMeUserItem.isModerator) return;
   			
   			//var ejectEvent : EjectUserEvent = new EjectUserEvent(data.userid);
   			//ejectEvent.dispatch();
   			sendNotification(MeetMeFacade.EJECT_USER_COMMAND, meetMeUserItem.data.userid);
   			
   			log.debug("MeetMeUserItem::ejectUser : [" + meetMeUserItem.data.userid + "]");
   		}

	}
}