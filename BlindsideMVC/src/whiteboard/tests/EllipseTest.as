package whiteboard.tests
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import model.component.*;
	
	public class EllipseTest extends TestCase
	{
		private var test:Ellipse;
		
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
			//fail("Testing Ellipse");
			var array:Array = [1,1,3,3,5,5,7,7,9,9];
			var L:Number = array.length;
			test = new Ellipse(array, 0xFFFF, 0x000F);
			assertTrue(this.test.getType() == DrawObject.ELLIPSE);
			//the shape should be optimized upon creation, so the array should have been changed
			assertFalse(this.test.getShapeArray().length == L);
			assertTrue(this.test.getShapeArray().length == 4);
			assertTrue(this.test.getShapeArray().pop() == 9);
			assertTrue(this.test.getShapeArray().pop() == 9);
			assertTrue(this.test.getShapeArray().pop() == 1);
			assertTrue(this.test.getShapeArray().pop() == 1);
			assertTrue(this.test.getShapeArray().length == 0);
		}

	}
}