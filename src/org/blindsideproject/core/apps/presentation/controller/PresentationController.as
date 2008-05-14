package org.blindsideproject.core.apps.presentation.controller
{
	import com.adobe.cairngorm.control.FrontController;
	import org.blindsideproject.core.apps.presentation.controller.handlers.*;
	
	public class PresentationController extends FrontController
	{
		public static const ID : String = "org.blindsideproject.core.apps.conference.contoller.PresentationController";
		
		public function PresentationController()
		{
			addCommand(PresentationController.GOTO_PAGE_COMMAND, GotoPageCommandHandler);
			addCommand(PresentationController.JOIN_COMMAND, JoinCommandHandler);
			addCommand(PresentationController.LOAD_COMMAND, LoadCommandHandler);
			addCommand(PresentationController.CLEAR_COMMAND, ClearCommandHandler);	
			addCommand(PresentationController.ASSIGN_COMMAND, AssignPresenterCommandHandler);
			addCommand(PresentationController.START_SHARE_COMMAND, StartSharingCommandHandler);
			addCommand(PresentationController.STOP_SHARE_COMMAND, StopSharingCommandHandler);
			addCommand(PresentationController.LEAVE_COMMAND, LeaveCommandHandler);	
			addCommand(PresentationController.UPLOAD_COMMAND, UploadCommandHandler);	
		}
		
		// List of Commands
		public static const GOTO_PAGE_COMMAND : String = "PRESENTATION_GOTO_PAGE_COMMAND";	
		public static const JOIN_COMMAND : String = "PRESENTATION_JOIN_COMMAND";
		public static const LEAVE_COMMAND : String = "PRESENTATION_LEAVE_COMMAND";
		public static const CLEAR_COMMAND : String = "PRESENTATION_CLEAR_COMMAND";
		public static const ASSIGN_COMMAND : String = "PRESENTATION_ASSIGN_COMMAND";
		public static const LOAD_COMMAND : String = "PRESENTATION_LOAD_COMMAND";
		public static const START_SHARE_COMMAND : String = "PRESENTATION_START_SHARE_COMMAND";
		public static const STOP_SHARE_COMMAND : String = "PRESENTATION_STOP_SHARE_COMMAND";
		public static const UPLOAD_COMMAND : String = "PRESENTATION_UPLOAD_COMMAND";
		
		// List of Events
		public static const READY_EVENT : String = "PRESENTATION_READY_EVENT";
		public static const CONVERT_SUCCESS_EVENT : String = "PRESENTATION_CONVERT_SUCCESS_EVENT";
		public static const UPDATE_PROGRESS_EVENT : String = "PRESENTATION_UPDATE_PROGRESS_EVENT";
		public static const EXTRACT_PROGRESS_EVENT : String = "PRESENTATION_EXTRACT_PROGRESS_EVENT";
		public static const CONVERT_PROGRESS_EVENT : String = "PRESENTATION_CONVERT_PROGRESS_EVENT";
		public static const CLEAR_EVENT : String = "PRESENTATION_CLEAR_EVENT";
		public static const VIEW_EVENT : String = "PRESENTATION_VIEW_EVENT";
		public static const UPLOAD_PROGRESS_EVENT : String = "PRESENTATION_UPLOAD_PROGRESS_EVENT";
		public static const UPLOAD_COMPLETED_EVENT : String = "PRESENTATION_UPLOAD_COMPLETED_EVENT";
		public static const UPLOAD_IO_ERROR_EVENT : String = "PRESENTATION_UPLOAD_IO_ERROR_EVENT";
		public static const UPLOAD_SECURITY_ERROR_EVENT : String = "PRESENTATION_UPLOAD_SECURITY_ERROR_EVENT";
		
	}
}