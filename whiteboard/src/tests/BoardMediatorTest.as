package tests
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	public class BoardMediatorTest extends TestCase
	{
		public function BoardMediatorTest(methodName:String)
		{
			super(methodName);
		}
		
		public static function suite():TestSuite{
			var ts:TestSuite = new TestSuite();
			
			ts.addTest(new BoardMediatorTest("testMediator"));
			
			return ts;
		}
		
		public function testMediator():void{
			fail("Testing Board Mediator");
		}

	}
}