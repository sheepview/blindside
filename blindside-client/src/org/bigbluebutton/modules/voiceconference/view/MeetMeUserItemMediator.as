package org.bigbluebutton.modules.voiceconference.view
{
	import flash.events.Event;
	
	import org.bigbluebutton.modules.voiceconference.VoiceConferenceFacade;
	import org.bigbluebutton.modules.voiceconference.control.notifiers.MuteNotifier;
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
		
		/**
		 * The defualt constructor 
		 * @param view - The gui component which this class mediates
		 * 
		 */		
		public function MeetMeUserItemMediator(view:MeetMeUserItem)
		{
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
					VoiceConferenceFacade.USER_JOIN_EVENT
					];
		}
		
		/**
		 * Handles a received notification 
		 * @param notification
		 * 
		 */		
		override public function handleNotification(notification:INotification):void{
			switch(notification.getName()){
				case VoiceConferenceFacade.USER_JOIN_EVENT:
					onNewMeetMeEvent(notification);
					break;
			}
		}
		
		/**
		 * Mutes or unmutes a user 
		 * 
		 */		
		private function muteUnmuteUser(e:Event) : void
   		{
   			if (! meetMeUserItem.isModerator) return;
   			
   			sendNotification(VoiceConferenceFacade.MUTE_EVENT, new MuteNotifier(meetMeUserItem.data.userid, !meetMeUserItem.data.isMuted));
   			
   			//log.debug("MeetMeUserItem::muteUnmuteUser : [" + meetMeUserItem.data.userid + "," + !meetMeUserItem.data.isMuted + "]");
   		}
   		
   		/**
   		 * Changes the display when a New MeetMeEvent is received 
   		 * @param note
   		 * 
   		 */   		
   		private function onNewMeetMeEvent(note:INotification) : void
   		{
   			//log.debug("Got newMeetMeEvent."); // comment out as generates too much noise

   			meetMeUserItem.displayStatusIcon();	
   		}

	}
}