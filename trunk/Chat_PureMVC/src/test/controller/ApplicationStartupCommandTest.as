package test.controller
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;

	public class ApplicationStartupCommandTest extends TestCase
	{
		public function ApplicationStartupCommandTest(methodName:String=null)
		{
			super(methodName);
		}
		public static function suite():TestSuite {
               var ts:TestSuite = new TestSuite();
               //ts.addTest( new MessageVOTest( "testGetInstance" ) );
               return ts;
           }
		
	}
}