package tests
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	public class ApplicationMediatorTest extends TestCase
	{
		public function ApplicationMediatorTest(methodName:String)
		{
			super(methodName);
		}
		
		public static function suite():TestSuite{
			var ts:TestSuite = new TestSuite();
			
			ts.addTest(new ApplicationMediatorTest("testAppMediator"));
			
			return ts;
		}
		
		public function testAppMediator():void{
			fail("Testing ApplicationMediator");
		}

	}
}