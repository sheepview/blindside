package org.bigbluebutton.modules.conference.model
{
	import flexunit.framework.TestCase;
	
	import org.bigbluebutton.modules.conference.model.business.ConferenceDelegate;
	import org.bigbluebutton.modules.conference.model.business.ConferenceServiceMock;
	import org.bigbluebutton.modules.conference.model.business.IConferenceDelegate;

	public class ConferenceDelegateTest extends TestCase
	{
		private var confDelegate : IConferenceDelegate = null;
		private var notificationName : String;
		private var body : Object;
		private var type : String;
		
		public function ConferenceDelegateTest(methodName:String=null)
		{
			super(methodName);
		}
		
  		public override function setUp():void
  		{
  			notificationName = null;
  			body = null;
  			type = null;
  			var mock : ConferenceServiceMock = new ConferenceServiceMock(
  			confDelegate = new ConferenceDelegate();
  		}
  		
  		public static function suite():TestSuite {
   			var ts:TestSuite = new TestSuite();
   			
   			ts.addTest( new ConferenceDelegateTest( "testLoginSuccess" ) );

   			return ts;
   		}		

		public function testLoginSuccess() : void {
			var cd : ConferenceDelegate = new ConferenceDelegate();
			cd.login(user, loginSuccess, loginFail);
			
		}	
		
 		private function sendNotification(notificationName:String, body:Object = null, type:String = null):void
 		{
 			
 		}
	}
}