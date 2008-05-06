package test.model
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;

	public class MessageVOTest extends TestCase
	{
		public function MessageVOTest(methodName:String=null)
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