package org.bigbluebutton.modules.conference.model
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import org.bigbluebutton.modules.conference.ConferenceConstants;
	import org.bigbluebutton.modules.conference.model.business.ConferenceDelegate;
	import org.bigbluebutton.modules.conference.model.business.ConferenceServiceMock;
	import org.bigbluebutton.modules.conference.model.business.IConferenceDelegate;
	import org.bigbluebutton.modules.conference.model.vo.UserVO;

	public class ConferenceDelegateTest extends TestCase
	{
		private var confDelegate : IConferenceDelegate = null;
		private var notificationName : String;
		private var body : Object;
		private var type : String;
		private var mock : ConferenceServiceMock;
		
		public function ConferenceDelegateTest(methodName:String=null)
		{
			super(methodName);
		}
		
  		public override function setUp():void
  		{
  			notificationName = null;
  			body = null;
  			type = null;
  			mock = new ConferenceServiceMock();
  			confDelegate = new ConferenceDelegate(sendNotification, mock);
			mock.confDelegate = confDelegate;
  		}
  		
  		public static function suite():TestSuite {
   			var ts:TestSuite = new TestSuite();
   			
   			ts.addTest( new ConferenceDelegateTest( "testJoinSuccess" ) );

   			return ts;
   		}		

		public function testJoinSuccess() : void {
  			
  						

   			mock.conference = 'mconf';
   			mock.viewPassword = 'mpass';
   			mock.userId = 200;
   			mock.authToken = "MODAUTHENTICATED";
   			
   			var user : UserVO = new UserVO("guest", "mpass", "mconf");
   			mock.join(user);
   			var joinUser : UserVO = body as UserVO;
   			
   			assertTrue("User has userId", joinUser.userId == 200);
   			assertTrue("User is authenticated", joinUser.authToken == "MODAUTHENTICATED");	
   			assertTrue("Send joined message", notificationName == ConferenceConstants.JOINED_CONFERENCE);		
		}	
		
 		private function sendNotification(notificationName:String, body:Object = null, type:String = null):void
 		{
 			this.notificationName = notificationName;
 			this.body = body;
 		}
	}
}