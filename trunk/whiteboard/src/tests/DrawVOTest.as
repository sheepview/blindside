package tests
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import model.DrawVO;
	import model.component.DrawObject;
	
	public class DrawVOTest extends TestCase
	{
		private var test:DrawVO;
		
		public function DrawVOTest(methodName:String)
		{
			super(methodName);
		}
		
		public static function suite():TestSuite{
			var ts:TestSuite = new TestSuite();
			
			ts.addTest(new DrawVOTest("testDrawVO"));
			
			return ts;
		}
		
		public function testDrawVO():void{
			//fail("Testing DrawVO");
			assertTrue(this.test == null);
			this.test = new DrawVO();
			assertTrue(this.test.segment == null);
			this.test.segment = new DrawObject("Hello",new Array(),5,6);
			assertFalse(this.test.segment == null);
			
		}

	}
}