package tests
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	public class RectangleTest extends TestCase
	{
		public function RectangleTest(methodName:String)
		{
			super(methodName);
		}
		
		public static function suite():TestSuite{
			var ts:TestSuite = new TestSuite();
			
			ts.addTest(new RectangleTest("testRectangle"));
			
			return ts;
		}
		
		public function testRectangle():void{
			fail("Testing Rectangle");
		}

	}
}