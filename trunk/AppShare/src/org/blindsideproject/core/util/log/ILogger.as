package org.blindsideproject.core.util.log
{
	public interface ILogger
	{			
		function debug(message : String):void;
		
		function info(message : String):void;

		function warn(message : String):void;

		function error(message : String):void;
	}
}