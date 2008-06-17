package org.bigbluebutton.modules.video.model.vo
{
	import org.bigbluebutton.modules.video.model.business.MediaType;
	
	public interface IMedia
	{
		function get streamName() : String;
		
		function set streamName(value : String) : void;
		
		function get uri() : String;
		
		function set uri(value : String) : void;

		function get type():MediaType;
	}
}