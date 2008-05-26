package org.bigbluebutton.modules.conference.model
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import org.bigbluebutton.modules.conference.model.business.ConferenceServiceMock;
	import org.bigbluebutton.modules.conference.model.business.IConferenceDelegate;
	import org.bigbluebutton.modules.conference.model.vo.UserVO;

	public class ConnectionServiceMockTest extends TestCase implements IConferenceDelegate
	{
		private var joinUser : UserVO;
		private var connected : Boolean = false;
		private var failReason : String;
		private var mock : ConferenceServiceMock;
		
		public function ConnectionServiceMockTest(methodName:String=null)
		{
			super(methodName);
		}

  		public override function setUp():void
  		{
  			mock = new ConferenceServiceMock();
  			mock.confDelegate = this;
  		}
  		
  		public override function tearDown():void
  		{
  			mock = null;
  		}
  		public static function suite():TestSuite {
   			var ts:TestSuite = new TestSuite();
   			
   			ts.addTest( new ConnectionServiceMockTest( "testConnectSuccess" ) );
			ts.addTest( new ConnectionServiceMockTest( "testJoinAsViewer" ) );
			ts.addTest( new ConnectionServiceMockTest( "testJoinAsModerator" ) );
			ts.addTest( new ConnectionServiceMockTest( "testJoinFailure" ) );
   			return ts;
   		}

  		public function testConnectSuccess() : void {	
  			
  			mock.connectResult = true;
  			mock.connect("localhost");
  			
 			assertTrue("Expecting successful login", connected == true);
   		} 
   		
   		public function testJoinAsViewer() : void
   		{
   			
   			mock.conference = 'vconf';
   			mock.viewPassword = 'vpass';
   			mock.userId = 100;
   			mock.authToken = "AUTHENTICATED";
   			
   			var user : UserVO = new UserVO("guest", "vpass", "vconf");
   			mock.join(user);
   			
   			assertTrue("User has userId", joinUser.userId == 100);
   			assertTrue("User is authenticated", joinUser.authToken == "AUTHENTICATED");
   		}

   		public function testJoinAsModerator() : void
   		{   			
   			mock.conference = 'mconf';
   			mock.viewPassword = 'mpass';
   			mock.userId = 200;
   			mock.authToken = "MODAUTHENTICATED";
   			
   			var user : UserVO = new UserVO("guest", "mpass", "mconf");
   			mock.join(user);
   			
   			assertTrue("User has userId", joinUser.userId == 200);
   			assertTrue("User is authenticated", joinUser.authToken == "MODAUTHENTICATED");
   		}

   		public function testJoinFailure() : void
   		{
   			
   			mock.conference = 'mconf';
   			mock.viewPassword = 'mpass';
   			mock.userId = 200;
   			mock.failReason = "DONT-LET-IN";
   			
   			var user : UserVO = new UserVO("guest", "fail", "mconf");
   			mock.join(user);
   			
   			assertTrue("Should not be able to join conference", failReason == "DONT-LET-IN");
   		}
   		
   		public function testGetParticipants() : void
   		{
   			
   		}
   		   		
   		/****************************
   		 * IConferenceDelegate FUNCTIONS 
   		 ****************************/
   		 
   		public function joinSuccess(user : UserVO) : void
   		{
   			joinUser = user;
   		}

   		public function joinFailed(reason : String) : void
   		{
   			failReason = reason;
   		}
   		   		
   		public function connectSuccess() : void
   		{
   			connected = true;
   		}

   		public function connectFailed() : void
   		{
   			connected = false;
   		}   			
   		
   		public function leftConference() : void
   		{
   			
   		}	
	}
}