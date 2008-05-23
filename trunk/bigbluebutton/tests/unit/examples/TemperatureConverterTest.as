package examples
{

 	import flexunit.framework.TestCase;
 	import flexunit.framework.TestSuite;
// 	import org.blindsideproject.core.util.log.ILogger;
//	import org.blindsideproject.core.util.log.LoggerModelLocator;
	
				
 	public class TemperatureConverterTest extends TestCase {
//		private var log : ILogger = LoggerModelLocator.getInstance().log;
		
   		private	var m : Media = new Media();
   		private	var mw : MediaWrapper = new MediaWrapper(m);
   		
   		[Bindable] private var r : String = mw.x;
   			  		
  	    public function TemperatureConverterTest( methodName:String ) {
   			super( methodName );
           }
  	
  		public override function setUp():void
  		{
  			m.y = "new value";
  		}
  		public static function suite():TestSuite {
   			var ts:TestSuite = new TestSuite();
   			
   			ts.addTest( new TemperatureConverterTest( "testToFahrenheit" ) );
   			ts.addTest( new TemperatureConverterTest( "testToCelsius" ) );
   			ts.addTest( new TemperatureConverterTest( "testWrapper" ) );
   			return ts;
   		}
  		
  		/**
  		 * Ensures the celsius to fahrenheit conversion works as expected.
  		 */
  		public function testToFahrenheit():void {
   			// Test boiling point
   			var celsius:Number = 100;
   			var fahrenheit:Number = TemperatureConverter.toFahrenheit( celsius );
   			assertTrue( "Expecting 212 fahrenheit", fahrenheit == 212 );
   			
   			// Test freezing point
   			celsius = 0;
   			fahrenheit = TemperatureConverter.toFahrenheit( celsius );
   			assertTrue( "Expecting 32 fahrenheit", fahrenheit == 32 );
   		}
  		
  		/**
  		 * Ensures the fahrenheit to celsius conversion works as expected.
  		 */
  		public function testToCelsius():void {
   			// Test boiling point
   			var fahrenheit:Number = 212;
   			var celsius:Number = TemperatureConverter.toCelsius( fahrenheit );
   			assertTrue( "Expecting 100 celsius", celsius == 100 );
   			
   			// Test freezing point
   			fahrenheit = 32;
   			celsius = TemperatureConverter.toCelsius( fahrenheit );
   			assertTrue( "Expecting 0 celsius", celsius == 0 );
   		}	
   		
   		public function testWrapper() : void
   		{			
   			
//   			log.info(r);
   		}
  }
}