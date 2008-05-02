package tests
{
	import controller.StartupCommand;
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	public class StartupCommandTest extends TestCase
	{
		private var test:StartupCommand;
		public function StartupCommandTest(methodName:String)
		{
			super(methodName);
		}
		
		public static function suite():TestSuite{
			var ts:TestSuite = new TestSuite();
			
			ts.addTest(new StartupCommandTest("testingStartupCommand"));
			
			return ts;
		}
		
		public function testingStartupCommand():void{
			//fail("Testing StartupCommand");
			test = new StartupCommand();
			var white:whiteboard = new whiteboard();
		}

	}
}