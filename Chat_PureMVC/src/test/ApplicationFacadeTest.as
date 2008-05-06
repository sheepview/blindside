package test
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;

	public class ApplicationFacadeTest extends TestCase
	{
		public function ApplicationFacadeTest(methodName:String=null)
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