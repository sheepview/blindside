package tests
{
	public class TemperatureConverter
	{
		public static function toFahrenheit(celsius : Number) : Number
		{
			return ( 9 / 5 ) * celsius + 32;
		}
		
		public static function toCelsius(fahrenheit : Number) : Number
		{
			return ( 5 / 9 ) * ( fahrenheit - 32 );
		}
	}
}