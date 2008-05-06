package test.view
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	public class ApplicationMediatorTest extends TestCase
	{
		public function ApplicationMediatorTest(methodName:String=null)
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