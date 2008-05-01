package org.blindsideproject.core.util.log
{
	import flash.system.Capabilities;
	
	public class NullLogger implements ILogger
	{
		public function Logger() {}
		
		public function debug(message : String):void {}
		
		private function logMessage( msg : String) : void {}

		public function info(message : String):void {}

		public function warn(message : String):void {}

		public function error(message : String):void {}
	}
}