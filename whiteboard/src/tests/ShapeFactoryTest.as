package tests
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	public class ShapeFactoryTest extends TestCase
	{
		public function ShapeFactoryTest(methodName:String)
		{
			super(methodName);
		}
		
		public static function suite():TestSuite{
			var ts:TestSuite = new TestSuite();
			
			ts.addTest(new ShapeFactoryTest("testShapeFactory"));
			
			return ts;
		}
		
		public function testShapeFactory():void{
			fail("Testing ShapeFactory");
		}

	}
}