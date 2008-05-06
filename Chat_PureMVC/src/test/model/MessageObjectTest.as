package test.model
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;

	public class MessageObjectTest extends TestCase
	{
		public function MessageObjectTest(methodName:String=null)
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