package org.bigbluebutton.modules.conference.model.business
{	
    import org.bigbluebutton.modules.conference.model.vo.Role;
    import org.bigbluebutton.modules.conference.model.vo.UserVO;
       
	public class ConnectionServiceMock
	{
		public var username : String = "guest";
		public var viewPassword : String = "vpass";
		public var modPassword : String = "mpass";
		public var conference : String = "conf";
		public var userId : Number = 1;
		public var authToken : String = 'authenticated';
		
		public var connectResult : Boolean = true;
		public var failReason : String = "Failed to join the conference.";
		
        public function ConnectionServiceMock() 
        {
        }

		public function connect(host : String, connectSuccess : Function, connectFailed : Function ) : void
		{
			connectResult ? connectSuccess() : connectFailed();						
		}
		
		public function join(user : UserVO, joinSuccess : Function, joinFailed : Function) : void
		{
			if ((conference == user.conference) && 
				((viewPassword == user.password) || (modPassword == user.password))) {
				if (viewPassword == user.password) {
					user.role = Role.VIEWER;
				} else if (modPassword == user.password) {
					user.role = Role.MODERATOR;
				}
				user.authToken = authToken;
				user.userId = userId;
				joinSuccess(user);
			} else {
				joinFailed(failReason);
			}
		}		
    }
}