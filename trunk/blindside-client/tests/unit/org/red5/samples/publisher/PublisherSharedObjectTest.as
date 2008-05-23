package org.red5.samples.publisher
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	import org.red5.samples.publisher.business.PublisherSharedObject;
	import mx.binding.utils.BindingUtils;
	import flash.events.NetStatusEvent;
	
	public class PublisherSharedObjectTest extends TestCase
	{					
  	    public function PublisherSharedObjectTest( methodName:String ) {
   			super( methodName );
           }
  	
  		public static function suite():TestSuite {
   			var ts:TestSuite = new TestSuite();
   			
   			ts.addTest( new PublisherSharedObjectTest( "testAddStream" ) );
   			ts.addTest( new PublisherSharedObjectTest( "testFindStream" ) );
   			ts.addTest( new PublisherSharedObjectTest( "testFailFindStream" ) );
   			ts.addTest( new PublisherSharedObjectTest( "testRemoveStream" ) );
//   			ts.addTest( new PublisherSharedObjectTest( "testBindConnected" ) );
   			return ts;
   		}		
   		
  		public function testAddStream():void {
  			var so : PublisherSharedObject = new PublisherSharedObject();
			so.addStream("1");	
			so.addStream("2");		
			assertTrue( "Expecting 2 stream", 2 == so.numberOfStreams );
   		}
  		
  		public function testFindStream() : void
  		{
  			var so : PublisherSharedObject = new PublisherSharedObject();
			so.addStream("1");	
			so.addStream("2");
  			var found : Boolean = false;
  			found = so.hasStream("1");
  			assertTrue( "Found stream 1", found == true );
  		}
  		
  		public function testFailFindStream() : void
  		{
   			var so : PublisherSharedObject = new PublisherSharedObject();
			so.addStream("1");	
			so.addStream("2");
  			var found : Boolean = false;
  			found = so.hasStream("3");
  			assertTrue( "Found stream 3", found == false ); 			
  		}
  		
  		public function testRemoveStream():void {
  			var so : PublisherSharedObject = new PublisherSharedObject();
			so.addStream("1");	
			so.addStream("2");  			
			so.removeStream("1");
			assertTrue( "Expecting 1 stream", 1 == so.numberOfStreams );
   		}   		
   		
   		public function testBindConnected() : void
   		{
   			var so : PublisherSharedObject = new PublisherSharedObject();

   			BindingUtils.bindProperty(this, "connected", so, "connected");  

   			so.connected = true;
   			
   		}
   		
   		public function set connected(value : Boolean) : void
   		{
   			assertTrue("Expecting connected = true", value == true);
   		}
	}
}