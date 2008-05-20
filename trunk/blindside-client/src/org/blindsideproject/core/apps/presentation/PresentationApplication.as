package org.blindsideproject.core.apps.presentation
{
				
	import flash.net.FileReference;
	
	import org.blindsideproject.core.apps.presentation.controller.notifiers.FileUploadNotifier;
	import org.blindsideproject.core.apps.presentation.controller.notifiers.JoinNotifier;
	import org.blindsideproject.core.apps.presentation.controller.notifiers.UserNotifier;
	import org.blindsideproject.core.apps.presentation.model.PresentationFacade;
	import org.blindsideproject.core.apps.presentation.model.PresentationModel;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
						
	public class PresentationApplication extends Mediator implements IMediator
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
			model = PresentationFacade.getInstance().presentation;
		}
		
		public function join() : void
		{
			sendNotification(PresentationFacade.JOIN_COMMAND, new JoinNotifier(_userid, _url, _room));			
		}
		
		public function leave() : void
		{
			sendNotification(PresentationFacade.LEAVE_COMMAND);
		}
		
		public function uploadPresentation(fileToUpload : FileReference) : void
		{
			var fullUri : String = _docServiceAddress + "/blindside/file/upload";
			sendNotification(PresentationFacade.UPLOAD_COMMAND, new FileUploadNotifier(fullUri, _room, fileToUpload));
		}
		
		public function loadPresentation() : void
		{
			var fullUri : String = _docServiceAddress + "/blindside/file/xmlslides?room=" + _room;	
			sendNotification(PresentationFacade.LOAD_COMMAND, fullUri);
		}
		
		public function sharePresentation(share : Boolean) : void
		{
			if (share) {	
				sendNotification(PresentationFacade.START_SHARE_COMMAND);				
			} else {
				sendNotification(PresentationFacade.STOP_SHARE_COMMAND);					
			}		
		}
		
		public function assignPresenter(userid : Number, name : String) : void
		{
			sendNotification(PresentationFacade.ASSIGN_COMMAND, new UserNotifier(userid, name));			
		}
	}
}