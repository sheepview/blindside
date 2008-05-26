package org.blindsideproject.core.apps.presentation.model
{
	import com.adobe.cairngorm.*;
	
	import org.blindsideproject.core.apps.presentation.PresentationApplication;
	import org.blindsideproject.core.apps.presentation.business.PresentationDelegate;
	import org.blindsideproject.core.apps.presentation.controller.StartPresentationAppCommand;
	import org.blindsideproject.core.apps.presentation.controller.StartUploadWindowCommand;
	import org.blindsideproject.core.apps.presentation.controller.StartupCommand;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
	import org.blindsideproject.views.presentation.PresentationWindow;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	public class PresentationFacade extends Facade implements IFacade
	{
		public static const ID : String = "PresentationFacade";
		public static const STARTUP:String = "startup";
		public static const STARTUPLOADWINDOW:String = "start upload";
		public static const START_PRESENTATION_APPLICATION:String = "start presentation app";
		
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
		
		private var _log : ILogger = LoggerModelLocator.getInstance().log;		
		private var _presentationDelegate : PresentationDelegate = null;	
		[Bindable]
		public var presentation : PresentationModel = new PresentationModel();
		public var presApp:PresentationApplication;
		
		public function PresentationFacade() : void
		{
			super(ID);		
		}

		public static function getInstance() : PresentationFacade
		{
			if ( instanceMap[ID] == null ) instanceMap[ID] = new PresentationFacade();
				
			return instanceMap[ID] as PresentationFacade;
	   	}	
	   	
	   	override protected function initializeController():void{
	   		super.initializeController();
	   		registerCommand(STARTUP, StartupCommand);
	   		registerCommand(STARTUPLOADWINDOW, StartUploadWindowCommand);
	   		registerCommand(START_PRESENTATION_APPLICATION, StartPresentationAppCommand);
	   	}	   	
	   	
	   	public function get presentationDelegate() : PresentationDelegate
	   	{
	   		if (_presentationDelegate == null) {
	   			_presentationDelegate = new PresentationDelegate();
	   		}
	   		
	   		return _presentationDelegate;
	   	}
	   	
	   	public function startup(app:PresentationWindow):void{
	 		  sendNotification(STARTUP, app);
	   	}
	   	
	   	public function setPresentationApp(userid : Number, room : String, 
				url : String, docServiceAddress : String):void{
			presApp = new PresentationApplication(userid, room, url, docServiceAddress);
	   		sendNotification(START_PRESENTATION_APPLICATION, presApp);
	   	}
	   	
	   	public function get presentationApp():PresentationApplication{
	   		return this.retrieveMediator(PresentationApplication.NAME) as PresentationApplication;
	   	}
	}
}