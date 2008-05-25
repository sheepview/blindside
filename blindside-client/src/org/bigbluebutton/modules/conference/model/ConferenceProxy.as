package org.bigbluebutton.modules.conference.model
{
	import mx.rpc.events.ResultEvent;
	
	import org.bigbluebutton.modules.conference.model.vo.UserVO;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class ConferenceProxy extends Proxy implements IProxy
	{
		public static const NAME : String			= 'ConferenceProxy';
		public static const LOGIN_ATTEMPT : String 	= 'loginAttempt';
		public static const LOGIN_SUCCESS : String 	= 'loginSuccess';
		public static const LOGIN_FAILED : String	= 'loginFailed';
		public static const LOGGED_OUT : String		= 'loggedOut';
		
		
		public function ConferenceProxy()
		{
			super(NAME, new UserVO());
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
				sendNotification( LOGIN_ATTEMPT );
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
			sendNotification( LOGGED_OUT );
		}
		
		private function onResult( event : ResultEvent ) : void
		{
			setData( event.result );
			sendNotification( LOGIN_SUCCESS , authToken );
		}
		
		private function onFault( event : FaultEvent ) : void
		{
			sendNotification( LOGIN_FAILED, event.fault.faultString );
		}
	}
}