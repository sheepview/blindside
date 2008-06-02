package org.bigbluebutton.modules.presentation
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import org.bigbluebutton.modules.presentation.model.PresentationApplication;
	import org.bigbluebutton.modules.presentation.model.services.PresentationService;
	
	public class PresentationServiceTest extends TestCase
	{
		private var test:PresentationService;
		private var application:PresentationApplication;
		
		public function PresentationServiceTest(methodName:String)
		{
			super(methodName);
		}
		
		public static function suite():TestSuite{
			var ts:TestSuite = new TestSuite();
			
			ts.addTest(new PresentationServiceTest("testPresentationService"));
			
			return ts;
		}
		
		override public function setUp():void{
			application = new PresentationApplication(5, "room", "host", "document");
			test = new PresentationService("host", application);
		}
		
		public function testPresentationService():void{
			fail("Not yet implemented");
		}

	}
}