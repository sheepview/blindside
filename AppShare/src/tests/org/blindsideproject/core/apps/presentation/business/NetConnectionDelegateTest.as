package tests.org.blindsideproject.core.apps.presentation.business
{
	import flexunit.framework.TestCase;
 	import flexunit.framework.TestSuite;
 	
	public class NetConnectionDelegateTest extends TestCase
	{
  	    public function NetConnectionDelegateTest( methodName:String ) {
   			super( methodName );
        }	
        
  		public static function suite() : TestSuite {
   			var ts:TestSuite = new TestSuite();
   			
   			ts.addTest( new NetConnectionDelegateTest( "testConnect" ) );
   			ts.addTest( new NetConnectionDelegateTest( "testDisconnect" ) );
   			return ts;
   		}      
   		
  		public function testConnect():void {

   		}

  		public function testDisconnect():void {

   		}   		   		  	
	}
}