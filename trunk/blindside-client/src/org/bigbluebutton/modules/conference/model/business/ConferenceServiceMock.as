package org.bigbluebutton.modules.conference.model.business
{	
    import mx.collections.ArrayCollection;
    
    import org.bigbluebutton.modules.conference.model.vo.Role;
    import org.bigbluebutton.modules.conference.model.vo.UserVO;
       
	public class ConferenceServiceMock implements IConferenceService
	{
		public var username : String = "guest";
		public var viewPassword : String = "vpass";
		public var modPassword : String = "mpass";
		public var conference : String = "conf";
		public var userId : Number = 1;
		public var authToken : String = 'authenticated';
		
		public var participants : ArrayCollection = new ArrayCollection();
		
		public var connectResult : Boolean = true;
		public var failReason : String = "Failed to join the conference.";
		
		public var confDelegate : IConferenceDelegate = null;
		
        public function ConferenceServiceMock() {}
        
		public function connect(host : String ) : void
		{
			connectResult ? confDelegate.connectSuccess() : confDelegate.connectFailed();						
		}
		
		public function join(user : UserVO ) : void
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
				confDelegate.joinSuccess(user);
			} else {
				confDelegate.joinFailed(failReason);
			}
		}		
		
		public function leave() : void
		{
			confDelegate.leftConference();
		}
    }
}