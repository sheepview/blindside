package tests
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	public class EllipseTest extends TestCase
	{
		public function EllipseTest(methodName:String)
		{
			super(methodName);
		}
		
		public static function suite():TestSuite{
			var ts:TestSuite = new TestSuite();
			
			ts.addTest(new EllipseTest("testEllipse"));
			
			return ts;
		}
		
		public function testEllipse():void{
			fail("Testing Ellipse");
		}

	}
}