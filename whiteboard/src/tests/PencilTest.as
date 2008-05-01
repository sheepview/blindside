package tests
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import model.component.*;
	
	public class PencilTest extends TestCase
	{
		private var test:Pencil;
		
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
			//fail("Testing Pencil");
			var array:Array = [1,1,3,3,5,5,7,7,9,9];
			var L:Number = array.length;
			test = new Pencil(array, 0xFFFF, 0x000F);
			assertTrue(this.test.getType() == DrawObject.PENCIL);
			//the array in the pencil should be unchanged since the pencil array does not get optimized
			assertTrue(this.test.getShapeArray().length == L);
			assertFalse(this.test.getShapeArray().length == 4);
			assertTrue(this.test.getShapeArray().pop() == 9);
			assertTrue(this.test.getShapeArray().pop() == 9);
			assertFalse(this.test.getShapeArray().pop() == 1);
			assertFalse(this.test.getShapeArray().pop() == 1);
			assertFalse(this.test.getShapeArray().length == 0);
		}

	}
}