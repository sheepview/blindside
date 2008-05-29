package org.bigbluebutton.modules.meetme.view
{
	import org.bigbluebutton.modules.meetme.MeetMeFacade;
	import org.bigbluebutton.modules.meetme.control.notifiers.MuteNotifier;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	/**
	 * This is the mediator class for the MeerMeUserItem GUI component
	 * <p>
	 * This class extends the Mediator class of the PureMVC framework 
	 * @author dzgonjan
	 * 
	 */	
	public class MeetMeUserItemMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "MeetMeUserItemMediator";
		public static const MUTE_UNMUTE_USER:String = "Mute-Unmute User";
		
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		
		/**
		 * The defualt constructor 
		 * @param view - The gui component which this class mediates
		 * 
		 */		
		public function MeetMeUserItemMediator(view:MeetMeUserItem)
		{
			log.debug("MeetMeUserMediator");
			super(NAME, view);
			view.addEventListener(MUTE_UNMUTE_USER, muteUnmuteUser);
		}
		
		/**
		 * 
		 * @return - the gui component of this mediator 
		 * 
		 */		
		public function get meetMeUserItem():MeetMeUserItem{
			return viewComponent as MeetMeUserItem;
		}
		
		/**
		 * 
		 * @return - the events which this class listens 
		 * <p>
		 * This class listens to the following notifications:
		 * 	MeetMeFacade.USER_JOIN_EVENT
		 * 
		 */		
		override public function listNotificationInterests():Array{
			return [
					MeetMeFacade.USER_JOIN_EVENT
					];
		}
		
		/**
		 * Handles a received notification 
		 * @param notification
		 * 
		 */		
		override public function handleNotification(notification:INotification):void{
			switch(notification.getName()){
				case MeetMeFacade.USER_JOIN_EVENT:
					onNewMeetMeEvent(notification);
					break;
			}
		}
		
		/**
		 * Mutes or unmutes a user 
		 * 
		 */		
		private function muteUnmuteUser() : void
   		{
   			if (! meetMeUserItem.isModerator) return;
   			
   			sendNotification(MeetMeFacade.MUTE_EVENT, new MuteNotifier(meetMeUserItem.data.userid, !meetMeUserItem.data.isMuted));
   			
   			log.debug("MeetMeUserItem::muteUnmuteUser : [" + meetMeUserItem.data.userid + "," + !meetMeUserItem.data.isMuted + "]");
   		}
   		
   		/**
   		 * Changes the display when a New MeetMeEvent is received 
   		 * @param note
   		 * 
   		 */   		
   		private function onNewMeetMeEvent(note:INotification) : void
   		{
   			log.debug("Got newMeetMeEvent."); // comment out as generates too much noise

   			meetMeUserItem.displayStatusIcon();	
   		}
   		
   		/**
   		 * Sends out a notification to eject a user 
   		 * 
   		 */   		
   		private function ejectUser() : void
   		{
   			if (! meetMeUserItem.isModerator) return;
   			
   			sendNotification(MeetMeFacade.EJECT_USER_COMMAND, meetMeUserItem.data.userid);
   			
   			log.debug("MeetMeUserItem::ejectUser : [" + meetMeUserItem.data.userid + "]");
   		}

	}
}