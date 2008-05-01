package tests
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	public class BoardMXMLTest extends TestCase
	{
		public function BoardMXMLTest(methodName:String)
		{
			super(methodName);
		}
		
		public static function suite():TestSuite{
			var ts:TestSuite = new TestSuite();
			
			ts.addTest(new BoardMXMLTest("testMain"));
			
			return ts;
		}
		
		public function testMain():void{
			fail("Testing Board.mxml");
		}

	}
}