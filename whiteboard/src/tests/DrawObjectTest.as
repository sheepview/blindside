package tests
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import model.component.DrawObject;
	
	public class DrawObjectTest extends TestCase
	{
		private var test:DrawObject;
		
		public function DrawObjectTest(methodName:String)
		{
			super(methodName);
		}
		
		public static function suite():TestSuite{
			var ts:TestSuite = new TestSuite();
			
			ts.addTest(new DrawObjectTest("testDrawObject"));
			
			return ts;
		}
		
		//DrawObject should in reality be an abstract class, but since we cannot have abstract classes
		//in ActionScript, we provide some minimal tests for the class
		public function testDrawObject():void{
			//fail("Testing DrawObject");
			assertTrue(this.test == null);
			this.test = new DrawObject(DrawObject.PENCIL, null, 0xFFFF, 5.32);
			assertFalse(this.test == null);
			assertTrue(this.test.getType() == DrawObject.PENCIL);
			assertFalse(this.test.getType() == DrawObject.ELLIPSE);
			assertTrue(this.test.getShapeArray() == null);
			assertTrue(this.test.getColor() == 0xFFFF);
			assertFalse(this.test.getColor() == 0x0000);
			assertTrue(this.test.getThickness() == 5.32);
			assertFalse(this.test.getThickness() == 4.00);
			
		}	

	}
}