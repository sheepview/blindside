package org.blindsideproject.core.apps.presentation.controller.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import flash.net.FileReference;

	import org.blindsideproject.core.apps.presentation.controller.PresentationController;
	
	public class UploadCommand extends CairngormEvent
	{
		private var _url : String;
		private var _room : String;
		private var _file : FileReference;
		
		public function UploadCommand(url : String, room : String, file : FileReference) : void
		{
			super(PresentationController.UPLOAD_COMMAND);
			_url = url;
			_room = room;
			_file = file;
		}
		
		public function get url() : String
		{
			return _url;
		}		
		
		public function get room() : String
		{
			return _room;
		}
		
		public function get file() : FileReference
		{
			return _file;
		}
	}
}