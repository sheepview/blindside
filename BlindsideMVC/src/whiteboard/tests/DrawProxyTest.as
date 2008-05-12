package whiteboard.tests
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	/**
	 * The ProxyTest is special because any test written for it would potentialy depend on whether the
	 * application is connected to the Red5 server or not. If anybody is willing to mock test the DrawProxy
	 * class or knows of a good way to do it, let me know! 
	 * @author dzgonjan
	 * 
	 */	
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
			//fail("The DrawProxy needs to be mock-tested with the Red5 server");
			
		}

	}
}