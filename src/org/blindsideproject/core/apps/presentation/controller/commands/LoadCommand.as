package org.blindsideproject.core.apps.presentation.controller.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.presentation.controller.PresentationController;

	public class LoadCommand extends CairngormEvent
	{
		private var _url : String;
		
		public function LoadCommand(url : String) : void
		{
			super(PresentationController.LOAD_COMMAND);
			_url = url;
		}
		
		public function get url() : String
		{
			return _url;
		}
	}
}