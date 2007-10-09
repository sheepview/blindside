package tests.org.blindsideproject.core.apps.conference
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	import org.blindsideproject.core.apps.conference.business.SharedObjectConferenceDelegate;
	import org.blindsideproject.core.apps.conference.model.Conference;

	public class SharedObjectConferenceDelegateTest extends TestCase
	{
		private var sod : SharedObjectConferenceDelegate;
		
  	    public function SharedObjectConferenceDelegateTest( methodName:String ) {
   			super( methodName );
           }
  	
  		public static function suite():TestSuite {
   			var ts:TestSuite = new TestSuite();
   			
//   			ts.addTest( new SharedObjectConferenceDelegateTest( "testAddParticipant" ) );
//   			ts.addTest( new SharedObjectConferenceDelegateTest( "testHasParticipant" ) );
//   			ts.addTest( new SharedObjectConferenceDelegateTest( "testGetParticipant" ) );
//   			ts.addTest( new SharedObjectConferenceDelegateTest( "testRemoveParticipant" ) );
//   			ts.addTest( new SharedObjectConferenceDelegateTest( "testRemoveAllParticipants" ) );
   			return ts;
   		}	
   		
   		public override function setUp() : void
   		{
   			sod = new SharedObjectConferenceDelegate(new Conference());
   		}	
   		
   		public override function tearDown():void
   		{
   			sod = null;
   		}	
   		
   		public function testConnectFailure() : void
   		{
   			var reason : String = "Invalid Application";
   			
//   			sod.connectFailed(reason);
//   			assertEquals("Failed reason not the same", sod.
   		}
	}
}