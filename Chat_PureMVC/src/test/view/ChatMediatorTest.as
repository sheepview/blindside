package test.view
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;

	public class ChatMediatorTest extends TestCase
	{
		public function ChatMediatorTest(methodName:String=null)
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