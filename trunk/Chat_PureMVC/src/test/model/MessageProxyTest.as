package test.model
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;

	public class MessageProxyTest extends TestCase
	{
		public function MessageProxyTest(methodName:String=null)
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