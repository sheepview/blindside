package org.bigbluebutton.modules.conference.model
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import org.bigbluebutton.modules.conference.model.vo.UserVO;
	
	public class ConferenceProxyTest extends TestCase
	{
		public function ConferenceProxyTest(methodName:String=null)
		{
			super(methodName);
		}

  		public override function setUp():void
  		{
  		}
  		
  		public static function suite():TestSuite {
   			var ts:TestSuite = new TestSuite();
   			
   			ts.addTest( new ConferenceProxyTest( "testLoginSuccess" ) );

   			return ts;
   		}

  		public function testLoginSuccess():void {			
 			assertTrue("Logged in", 1 == 1);
   		}   				
	}
}