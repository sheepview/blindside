package tests
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	public class BoardFacadeTest extends TestCase
	{
		public function BoardFacadeTest(methodName:String)
		{
			super(methodName);
		}
		
		public static function suite():TestSuite{
			var ts:TestSuite = new TestSuite();
			
			ts.addTest(new BoardFacadeTest("testBoardFacade"));
			
			return ts;
		}
		
		public function testBoardFacade():void{
			fail("Testing BoardFacade");
		}

	}
}