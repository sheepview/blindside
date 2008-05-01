package tests
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	public class DrawObjectFactoryTest extends TestCase
	{
		public function DrawObjectFactoryTest(methodName:String)
		{
			super(methodName);
		}
		
		public static function suite():TestSuite{
			var ts:TestSuite = new TestSuite();
			
			ts.addTest(new DrawObjectFactoryTest("testDrawObjectFactory"));
			
			return ts;
		}
		
		public function testDrawObjectFactory():void{
			fail("Testing DrawObjectFactory");
		}

	}
}