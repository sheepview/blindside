package org.blindsideproject.core.apps.presentation.business
{
	import flexunit.framework.TestCase;

	public class PresentationSharedObjectTest extends TestCase
	{
  	    public function PresentationSharedObjectTest( methodName:String ) {
   			super( methodName );
        }	
        
  		public static function suite() : TestSuite {
   			var ts:TestSuite = new TestSuite();
   			
   			ts.addTest( new PresentationSharedObjectTest( "testConnect" ) );
   			ts.addTest( new PresentationSharedObjectTest( "testDisconnect" ) );
   			return ts;
   		}   
   		
  		public function testConnect():void {

   		}

  		public function testDisconnect():void {

   		}  
	}
}