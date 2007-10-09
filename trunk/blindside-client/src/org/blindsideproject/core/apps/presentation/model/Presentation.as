package org.blindsideproject.core.apps.presentation.model
{

	public class Presentation
	{
		private var _connected : Boolean = false;		
		private var _host : String;
		
		public function Presentation(host : String) : void
		{
			_host = host;
		}
				
		public function get connected() : Boolean
		{
			return _connected;
		}
								
		public function get host() : String
		{
			return _host;
		}		
	}
}