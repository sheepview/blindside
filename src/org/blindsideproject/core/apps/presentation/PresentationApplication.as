package org.blindsideproject.core.apps.presentation
{
	import org.blindsideproject.core.apps.presentation.controller.commands.UploadCommand;
	import org.blindsideproject.core.apps.presentation.controller.commands.JoinCommand;
	import org.blindsideproject.core.apps.presentation.controller.commands.LoadCommand;
	import org.blindsideproject.core.apps.presentation.controller.commands.LeaveCommand;
	import org.blindsideproject.core.apps.presentation.controller.commands.StartSharingCommand;
	import org.blindsideproject.core.apps.presentation.controller.commands.StopSharingCommand;
	import org.blindsideproject.core.apps.presentation.controller.commands.AssignPresenterCommand;
				
	import org.blindsideproject.core.apps.presentation.model.PresentationModelLocator;
	import org.blindsideproject.core.apps.presentation.model.PresentationModel;
	
	import flash.net.FileReference;
						
	public class PresentationApplication
	{
		public var model : PresentationModel; 

		private var _url : String;
		private var _userid : Number;
		private var _room : String;
		private var _docServiceAddress : String = "http://localhost:8080";
		
		public function PresentationApplication(userid : Number, room : String, 
				url : String, docServiceAddress : String) : void 
		{
			_url = url;
			_userid = userid;
			_room = room;
			_docServiceAddress = docServiceAddress;
			
			// Initialize the model
			model = PresentationModelLocator.getInstance().presentation;
		}
		
		public function join() : void
		{
			var joinCmd : JoinCommand = new JoinCommand(_userid, _url, _room);
			joinCmd.dispatch();						
		}
		
		public function leave() : void
		{
			var leaveCmd : LeaveCommand = new LeaveCommand();
			leaveCmd.dispatch();
		}
		
		public function uploadPresentation(fileToUpload : FileReference) : void
		{
			var fullUri : String = _docServiceAddress + "/blindside/file/upload";
			
			var uploadCmd : UploadCommand = new UploadCommand(fullUri, _room, fileToUpload);
			uploadCmd.dispatch();
		}
		
		public function loadPresentation() : void
		{
			var fullUri : String = _docServiceAddress + "/blindside/file/xmlslides?room=" + _room;
			var loadCmd : LoadCommand = new LoadCommand(fullUri);
			loadCmd.dispatch();				
		}
		
		public function sharePresentation(share : Boolean) : void
		{
			if (share) {
				var shareCmd : StartSharingCommand = new StartSharingCommand();
				shareCmd.dispatch();					
			} else {
				var stopShareCmd : StopSharingCommand = new StopSharingCommand();
				stopShareCmd.dispatch();					
			}		
		}
		
		public function assignPresenter(userid : Number, name : String) : void
		{
			var assignPresenterCmd : AssignPresenterCommand 
					= new AssignPresenterCommand(userid, name);
			assignPresenterCmd.dispatch();				
		}
	}
}