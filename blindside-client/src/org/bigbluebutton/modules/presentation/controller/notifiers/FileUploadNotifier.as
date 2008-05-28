package org.bigbluebutton.modules.presentation.controller.notifiers
{
	import flash.net.FileReference;
	
	public class FileUploadNotifier
	{
		private var _fullURI:String;
		private var _room:String;
		private var _file:FileReference;
		
		public function FileUploadNotifier(fullUri:String, room:String, file:FileReference)
		{
			this._file = file;
			this._fullURI = fullUri;
			this._room = room;
		}
		
		public function get file():FileReference{
			return this._file;
		}
		
		public function get room():String{
			return this.room;
		}
		
		public function get uri():String{
			return this._fullURI;
		}

	}
}