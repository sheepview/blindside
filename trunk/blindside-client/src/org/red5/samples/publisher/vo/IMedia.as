package org.red5.samples.publisher.vo
{
	import org.red5.samples.publisher.MediaType;
	
	public interface IMedia
	{
		function get streamName() : String;
		
		function set streamName(value : String) : void;
		
		function get uri() : String;
		
		function set uri(value : String) : void;

		function get type() : MediaType;
	}
}