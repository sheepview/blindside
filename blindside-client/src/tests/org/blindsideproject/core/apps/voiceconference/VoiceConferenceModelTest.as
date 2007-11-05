package tests.org.blindsideproject.core.apps.voiceconference
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	import org.blindsideproject.core.apps.voiceconference.model.VoiceConference;
	import org.blindsideproject.core.apps.voiceconference.controller.VoiceConferenceController;


	public class VoiceConferenceModelTest extends TestCase
	{
		private var c : VoiceConference;
		private var v : VoiceConferenceController;
		
  	    public function VoiceConferenceModelTest( methodName:String ) {
   			super( methodName );
           }
  	
  		public static function suite():TestSuite {
   			var ts:TestSuite = new TestSuite();
   			
   			ts.addTest( new VoiceConferenceModelTest( "testAddParticipant" ) );
   			ts.addTest( new VoiceConferenceModelTest( "testHasParticipant" ) );
   			ts.addTest( new VoiceConferenceModelTest( "testGetParticipant" ) );
   			ts.addTest( new VoiceConferenceModelTest( "testRemoveParticipant" ) );
   			ts.addTest( new VoiceConferenceModelTest( "testRemoveAllParticipants" ) );
   			return ts;
   		}	
   		
   		public override function setUp() : void
   		{

   		}
   		
   		public override function tearDown() : void
   		{
   			c = null;
   		}
   		
   		public function testAddParticipant():void {

   		}		

   		public function testHasParticipant():void 
   		{

   		}	
   		
   		public function testGetParticipant() : void
   		{ 			
  			
   		}
   		
   		public function testRemoveParticipant() : void
   		{

   		}
   		
   		public function testRemoveAllParticipants() : void
   		{

   		}
	}
}