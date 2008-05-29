package org.bigbluebutton.modules.log.interface
{
	public interface ILogger
	{			
		function debug(message : String):void;
		
		function info(message : String):void;

		function warn(message : String):void;

		function error(message : String):void;
		
		function set debugEnabled(value : Boolean) : void;
		function set infoEnabled(value : Boolean) : void;
		function set warnEnabled(value : Boolean) : void;
		function set errorEnabled(value : Boolean) : void;
	}
}