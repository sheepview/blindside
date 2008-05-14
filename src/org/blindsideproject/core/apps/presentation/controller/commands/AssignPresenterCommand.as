package org.blindsideproject.core.apps.presentation.controller.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.presentation.controller.PresentationController;

	public class AssignPresenterCommand extends CairngormEvent
	{
		private var _userid : Number;
		private var _name : String;
		
		public function AssignPresenterCommand(userid : Number, name : String) : void
		{
			super(PresentationController.ASSIGN_COMMAND);
			_userid = userid
			_name = name;
		}
		
		public function get userid() : Number
		{
			return _userid;
		}	
		
		public function get name() : String
		{
			return _name;
		}	
	}
}