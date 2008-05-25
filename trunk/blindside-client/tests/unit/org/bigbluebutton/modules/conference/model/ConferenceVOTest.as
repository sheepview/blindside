package org.bigbluebutton.modules.conference.model
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import org.bigbluebutton.modules.conference.model.vo.ConferenceVO;
	import org.bigbluebutton.modules.conference.model.vo.ParticipantVO;
	import org.bigbluebutton.modules.conference.model.vo.Role;

	public class ConferenceVOTest extends TestCase
	{
		private var conferenceVO : ConferenceVO;
		
		public function ConferenceVOTest(methodName:String=null)
		{
			super(methodName);
		}

  		public override function setUp():void
  		{
			conferenceVO = new ConferenceVO();  			
   			var p0 : ParticipantVO = new ParticipantVO("guest0", 0, Role.ADMINISTRATOR);
   			conferenceVO.addParticipant(p0);  			
   			
   			var p1 : ParticipantVO = new ParticipantVO("guest1", 1, Role.MODERATOR);
   			conferenceVO.addParticipant(p1);

  		}

   		public override function tearDown() : void
   		{
   			conferenceVO = null;
   		}
  		
  		public static function suite():TestSuite {
   			var ts:TestSuite = new TestSuite();
   			
   			ts.addTest( new ConferenceVOTest( "testAddParticipant" ) );
			ts.addTest( new ConferenceVOTest( "testHasParticipant" ) );
			ts.addTest( new ConferenceVOTest( "testGetParticipant" ) );
			ts.addTest( new ConferenceVOTest( "testRemoveParticipant" ) );
			ts.addTest( new ConferenceVOTest( "testRemoveAllParticipants" ) );
   			return ts;
   		}
   		
 		public function testAddParticipant():void {
			var p1 : ParticipantVO = new ParticipantVO("guest3", 3, Role.VIEWER);
			conferenceVO.addParticipant(p1);

			// The other two should have been added during setup()
   			assertTrue("Expecting 3 participants", conferenceVO.participants.length == 3);
   		}    		

   		public function testHasParticipant():void 
   		{
   			assertTrue("Expecting 2 participants", 2 == conferenceVO.participants.length);   			
   			assertTrue("Expecting to find participant 1", conferenceVO.hasParticipant(1));
   		}	
   		
   		public function testGetParticipant() : void
   		{ 			
   			var r : ParticipantVO = conferenceVO.getParticipant(1);
   			assertNotNull("Participant was null", r);   			
   		}
   		
   		public function testRemoveParticipant() : void
   		{
   			conferenceVO.removeParticipant(1);
   			assertFalse("User was found", conferenceVO.hasParticipant(1));
   			assertTrue("Expecting 1 participant", conferenceVO.participants.length == 1);
   		}
   		
   		public function testRemoveAllParticipants() : void
   		{
   			conferenceVO.removeAllParticipants();
   			assertTrue("Expecting 0 participants", conferenceVO.participants.length == 0);
   		}
   				
	}
}