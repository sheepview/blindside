package org.bigbluebutton.modules.conference.model
{
	import org.bigbluebutton.modules.conference.model.vo.ConferenceVO;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class ConferenceProxy extends Proxy implements IProxy
	{
		public static const NAME : String			= 'ConferenceProxy';
		private var confHost : String;
		
		public function ConferenceProxy(host : String)
		{
			super(NAME, new ConferenceVO());
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
				sendNotification( ConferenceConstants.LOGIN_ATTEMPT );
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
			sendNotification( ConferenceConstants.LOGGED_OUT );
		}
		
		private function loginSuccessful( userId : Number, authToken : String ) : void
		{
			setData( event.result );
			sendNotification( ConferenceConstants.LOGIN_SUCCESS );
		}
		
		private function loginFailed( reason : String ) : void
		{
			sendNotification( ConferenceConstants.LOGIN_FAILED, reason );
		}
	}
}