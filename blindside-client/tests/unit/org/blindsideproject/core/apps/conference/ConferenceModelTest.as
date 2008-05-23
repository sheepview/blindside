package org.blindsideproject.core.apps.conference
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	import org.blindsideproject.core.apps.conference.vo.User;
	import org.blindsideproject.core.apps.conference.vo.Role;
	import org.blindsideproject.core.apps.conference.model.Conference;

	public class ConferenceModelTest extends TestCase
	{
		private var c : Conference;
		
  	    public function ConferenceModelTest( methodName:String ) {
   			super( methodName );
           }
  	
  		public static function suite():TestSuite {
   			var ts:TestSuite = new TestSuite();
   			
   			ts.addTest( new ConferenceModelTest( "testAddParticipant" ) );
   			ts.addTest( new ConferenceModelTest( "testHasParticipant" ) );
   			ts.addTest( new ConferenceModelTest( "testGetParticipant" ) );
   			ts.addTest( new ConferenceModelTest( "testRemoveParticipant" ) );
   			ts.addTest( new ConferenceModelTest( "testRemoveAllParticipants" ) );
   			return ts;
   		}	
   		
   		public override function setUp() : void
   		{
   			var p0 : User = new User();
   			p0.userid = 0;
   			p0.name = "gomez";
   			p0.role = Role.ADMINISTRATOR;
   			   			
   			c = new Conference(); 
   			c.addUser(p0);  			
   			
   			var p1 : User = new User();
   			p1.userid = 1;
   			p1.name = "burgos";
   			p1.role = Role.MODERATOR;
   			c.addUser(p1);
   		}
   		
   		public override function tearDown() : void
   		{
   			c = null;
   		}
   		
   		public function testAddParticipant():void {
   			var p3 : User = new User();
   			p3.userid = 3;
   			p3.name = "zamora";
   			p3.role = Role.MODERATOR;
   			c.addUser(p3);

			// The other two should have been added during setup()
   			assertTrue("Expecting 3 participants", 3 == c.users.length);
   		}		

   		public function testHasParticipant():void 
   		{
   			assertTrue("Expecting 2 participants", 2 == c.users.length);   			
   			assertTrue("Expecting to find participant 1", c.hasParticipant(1));
   		}	
   		
   		public function testGetParticipant() : void
   		{ 			
   			var r : User = c.getParticipant(1);
   			assertNotNull("Participant was null", r);   			
   		}
   		
   		public function testRemoveParticipant() : void
   		{
   			c.removeParticipant(1);
   			assertFalse("User was found", c.hasParticipant(1));
   			assertTrue("Expecting 1 participant", c.users.length == 1);
   		}
   		
   		public function testRemoveAllParticipants() : void
   		{
   			c.removeAllParticipants();
   			assertTrue("Expecting 0 participants", c.users.length == 0);
   		}
	}
}