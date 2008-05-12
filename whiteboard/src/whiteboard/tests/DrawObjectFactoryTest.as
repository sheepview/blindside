package whiteboard.tests
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import model.component.DrawObject;
	import model.component.DrawObjectFactory;
	
	public class DrawObjectFactoryTest extends TestCase
	{
		private var test:DrawObjectFactory;
		public function DrawObjectFactoryTest(methodName:String)
		{
			super(methodName);
		}
		
		public static function suite():TestSuite{
			var ts:TestSuite = new TestSuite();
			
			ts.addTest(new DrawObjectFactoryTest("testMakeDrawObject"));
			ts.addTest(new DrawObjectFactoryTest("testMakePencil"));
			ts.addTest(new DrawObjectFactoryTest("testMakeEllipse"));
			ts.addTest(new DrawObjectFactoryTest("testMakeRectangle"));
			
			return ts;
		}
		
		public function testMakeDrawObject():void{
			//fail("Testing DrawObjectFactory");
			this.test = new DrawObjectFactory();
			assertTrue(test.makeDrawObject(DrawObject.PENCIL,new Array(), 0x00FF, 0x0FFF).getType() == DrawObject.PENCIL);
			assertTrue(test.makeDrawObject(DrawObject.ELLIPSE, new Array(), 0x0000, 0x00F0).getType() == DrawObject.ELLIPSE);
			assertTrue(test.makeDrawObject(DrawObject.RECTANGLE, new Array(), 0x000A, 0x000C).getType() == DrawObject.RECTANGLE);
		}
		
		public function testMakePencil():void{
			this.test = new DrawObjectFactory();
			var pencil:DrawObject = test.makePencil(new Array(),0x00FA, 0x0003);
			assertTrue(pencil.getType() == DrawObject.PENCIL);
			assertTrue(pencil.getColor() == 0x00FA);
			assertTrue(pencil.getThickness() == 0x0003);
		}
		
		public function testMakeEllipse():void{
			this.test = new DrawObjectFactory();
			var ellipse:DrawObject = test.makeEllipse(new Array(),0x00FA, 0x0003);
			assertTrue(ellipse.getType() == DrawObject.ELLIPSE);
			assertTrue(ellipse.getColor() == 0x00FA);
			assertTrue(ellipse.getThickness() == 0x0003);
		}
		
		public function testMakeRectangle():void{
			this.test = new DrawObjectFactory();
			var rectangle:DrawObject = test.makeRectangle(new Array(),0x00FA, 0x0003);
			assertTrue(rectangle.getType() == DrawObject.RECTANGLE);
			assertTrue(rectangle.getColor() == 0x00FA);
			assertTrue(rectangle.getThickness() == 0x0003);		
		}

	}
}