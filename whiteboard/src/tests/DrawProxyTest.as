package tests
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	public class DrawProxyTest extends TestCase
	{
		public function DrawProxyTest(methodName:String)
		{
			super(methodName);
		}
		
		public static function suite():TestSuite{
			var ts:TestSuite = new TestSuite();
			
			ts.addTest(new DrawProxyTest("testDrawProxy"));
			
			return ts;
		}
		
		public function testDrawProxy():void{
			fail("Testing DrawProxy");
		}

	}
}