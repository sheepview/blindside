package org.bigbluebutton.modules.conference.model
{
	import org.bigbluebutton.modules.conference.ConferenceConstants;
	import org.bigbluebutton.modules.conference.model.business.IConferenceDelegate;
	import org.bigbluebutton.modules.conference.model.business.IConferenceService;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class ConferenceProxy extends Proxy implements IProxy
	{
		public static const NAME : String			= 'ConferenceProxy';
		public var host : String = 'localhost';
		
		private
		public function ConferenceProxy(confService : IConferenceService)
		{
			super(NAME);
			confHost = host;
		}
		
		public function get userVO() : UserVO
		{
			return data as UserVO;
		}
		
		public function get loggedIn() : Boolean
		{
			return (authToken != null);
		}
		
		public function get authToken() : String
		{
			return userVO.authToken;
		}
		
		public login( user : UserVO ) : void
		{
			if ( ! loggedIn ) {
				sendNotification( ConferenceConstants.JOIN_ATTEMPT );
				userVO.username = user.username;
				userVO.password = user.password;
			} else {
				logout();
				login(user);
			}
		}
		
		public function logout() : void
		{
			if ( loggedIn ) userVO = new UserVO();
			sendNotification( ConferenceConstants.LEFT_CONFERENCE );
		}
		
		private function loginSuccessful( userId : Number, authToken : String ) : void
		{
			setData( event.result );
			sendNotification( ConferenceConstants.JOINED_CONFERENCE );
		}
		
		private function loginFailed( reason : String ) : void
		{
			sendNotification( ConferenceConstants.JOIN_FAILED, reason );
		}
  
	}
}