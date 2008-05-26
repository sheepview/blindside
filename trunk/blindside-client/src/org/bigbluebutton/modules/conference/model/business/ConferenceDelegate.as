package org.bigbluebutton.modules.conference.model.business
{
	import org.bigbluebutton.modules.conference.ConferenceConstants;
	import org.bigbluebutton.modules.conference.model.vo.ConferenceVO;
	import org.bigbluebutton.modules.conference.model.vo.UserVO;
	
	public class ConferenceDelegate implements IConferenceDelegate
	{
		private var conferenceVO : ConferenceVO;
		private var sendNotification : Function;
		private var confService : IConferenceService;
		
		public function ConferenceDelegate(notify : Function, service : IConferenceService)
		{
			sendNotification = notify;
			confService = service;
		}

		public function get conferenceModel() : ConferenceVO
		{
			return conferenceVO;
		}
		
   		/****************************
   		 * IConferenceDelegate FUNCTIONS 
   		 ****************************/
   		 
   		public function joinSuccess(user : UserVO) : void
   		{
			sendNotification( ConferenceConstants.JOINED_CONFERENCE , user);
   		}

   		public function joinFailed(reason : String) : void
   		{
			sendNotification( ConferenceConstants.JOIN_FAILED, reason );
   		}
   		   		
   		public function connectSuccess() : void
   		{

   		}

   		public function connectFailed() : void
   		{

   		}   	
   		
   		public function leftConference() : void
   		{
   			
   		}	
	}
}