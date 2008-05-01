package tests
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	public class PencilTest extends TestCase
	{
		public function PencilTest(methodName:String)
		{
			super(methodName);
		}
		
		public static function suite():TestSuite{
			var ts:TestSuite = new TestSuite();
			
			ts.addTest(new PencilTest("testPencil"));
			
			return ts;
		}
		
		public function testPencil():void{
			fail("Testing Pencil");
		}

	}
}