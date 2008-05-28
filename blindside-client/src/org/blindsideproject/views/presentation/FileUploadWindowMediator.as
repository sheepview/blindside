package org.blindsideproject.views.presentation
{
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	
	import mx.controls.Alert;
	import mx.managers.PopUpManager;
	
	import org.bigbluebutton.modules.presentation.controller.notifiers.ProgressNotifier;
	import org.bigbluebutton.modules.presentation.model.PresentationFacade;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
	import org.blindsideproject.main.BlindsideAppLocator;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class FileUploadWindowMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "FileUploadWindowMediator";
		
		public static const START_UPLOAD:String = "Start Upload";
		public static const CLOSE_UPLOAD_WINDOW:String = "Close File Upload Window";
		public static const SELECT_FILE:String = "Select File";
		
		private var log:ILogger = LoggerModelLocator.getInstance().log;
		private var fileToUpload:FileReference = new FileReference();
		// Var to determine how to handle okCancelBtn click
		private var okState : Boolean = false;
		
		public var isListening:Boolean = true;
		
		/**
		 * The default constructor. Creates this mediator 
		 * @param view The GUI component which this class serves as a mediator for.
		 * 
		 */		
		public function FileUploadWindowMediator(view:FileUploadWindow)
		{
			super(NAME,view);
			fileUploadWindow.addEventListener(START_UPLOAD, startUpload);
			fileUploadWindow.addEventListener(CLOSE_UPLOAD_WINDOW, closeFileUploadWindow);
			fileUploadWindow.addEventListener(SELECT_FILE, selectFile);
			log.debug("FileUploadMediator Created");
		}
		
		/**
		 * Returns the Board GUI component that is registered to this Mediator object 
		 * @return 
		 * 
		 */		
		protected function get fileUploadWindow():FileUploadWindow{
			return viewComponent as FileUploadWindow;
		}
		
		private function startUpload(e:Event):void{
			BlindsideAppLocator.getInstance().presentationFacade.presentationApp.uploadPresentation(fileToUpload);
							
			fileUploadWindow.progBarLbl.visible = true;
			fileUploadWindow.progressBar.visible = true;
			
			fileUploadWindow.okCancelBtn.visible = false;
			fileUploadWindow.selectBtn.enabled = false;
			fileUploadWindow.uploadBtn.enabled = false;
			fileUploadWindow.fileTxtInput.enabled = false;
		}
		
		private function closeFileUploadWindow(e:Event) : void
		{
			if (okState) {
				sendNotification(PresentationFacade.READY_EVENT);
			}
			enableControls();
			PopUpManager.removePopUp(fileUploadWindow);
		}
		
		private function onSelectFile(e:Event):void
		{
			fileUploadWindow.fileTxtInput.text = fileToUpload.name;
			fileUploadWindow.uploadBtn.enabled = true;
		}
		
		private function selectFile(e:Event):void{
			fileToUpload.addEventListener(Event.SELECT, onSelectFile);	
			fileToUpload.browse([new FileFilter("PDF", "*.pdf")]);
		}
		
		/**
		 * Lists the notifications in which this class is interested. 
		 * @return An array of Strings representing notifications
		 * 
		 */		
		override public function listNotificationInterests():Array{
			return [
					PresentationFacade.UPLOAD_COMPLETED_EVENT,
					PresentationFacade.UPLOAD_PROGRESS_EVENT,
					PresentationFacade.UPLOAD_IO_ERROR_EVENT,
					PresentationFacade.UPLOAD_SECURITY_ERROR_EVENT,
					PresentationFacade.CONVERT_PROGRESS_EVENT,
					PresentationFacade.EXTRACT_PROGRESS_EVENT,
					PresentationFacade.UPDATE_PROGRESS_EVENT,
					PresentationFacade.CONVERT_SUCCESS_EVENT
					];
		}
		
		/**
		 * Method is executed when the class receives one of the notifications it is interested in 
		 * @param notification The received notification
		 * 
		 */		
		override public function handleNotification(notification:INotification):void{
			log.debug("Upload Mediator: notification : " + notification.getName());
			if (isListening == false) return;
			switch(notification.getName()){
				case PresentationFacade.UPLOAD_COMPLETED_EVENT:
					handleUploadCompleteEvent(notification);
					break;
				case PresentationFacade.UPLOAD_PROGRESS_EVENT:
					handleUploadProgressEvent(notification);
					break;
				case PresentationFacade.UPLOAD_IO_ERROR_EVENT:
					handleUploadIOErrorEvent(notification);
					break;
				case PresentationFacade.UPLOAD_SECURITY_ERROR_EVENT:
					handleUploadSecurityErrorEvent(notification);
					break;
				case PresentationFacade.CONVERT_PROGRESS_EVENT:
					handleConvertProgressEvent(notification);
					break;
				case PresentationFacade.EXTRACT_PROGRESS_EVENT:
					handleExtractProgressEvent(notification);
					break;
				case PresentationFacade.UPDATE_PROGRESS_EVENT:
					handleUpdateProgressEvent(notification);
					break;
				case PresentationFacade.CONVERT_SUCCESS_EVENT:
					handleConvertSuccessEvent(notification);
					break;
			}
		}
		
		private function handleUploadCompleteEvent(note:INotification):void{
			fileUploadWindow.progressLbl.text = "Upload completed. Please wait while we convert the document."
			fileUploadWindow.progressBar.label = "Upload successful.";
			fileUploadWindow.progressBar.setProgress(0, 100);
			fileUploadWindow.progressBar.validateNow();

			fileUploadWindow.fileLbl.visible = false;
			fileUploadWindow.selectBtn.visible = false;
			fileUploadWindow.uploadBtn.visible = false;
			fileUploadWindow.fileTxtInput.visible = false;
		}
		
		private function handleUploadProgressEvent(note:INotification):void{
			var progress:Number = note.getBody() as Number;
			
			fileUploadWindow.progressBar.label = progress + "% uploaded.";
			fileUploadWindow.progressBar.setProgress(progress, 100);
			fileUploadWindow.progressBar.validateNow();
		}
		
		private function handleUploadIOErrorEvent(note:INotification):void{
			enableControls();
			Alert.show(note.getBody() as String, "IO Error When Uploading File");
		}
		
		private function handleUploadSecurityErrorEvent(note:INotification):void{
			enableControls();
			Alert.show(note.getBody() as String, "Security Error When Uploading File");
		}
		
		private function handleConvertProgressEvent(note:INotification):void{
			var convertEvt:ProgressNotifier = note.getBody() as ProgressNotifier;

			fileUploadWindow.progressBar.label = "Converting slide " + convertEvt.completedSlides + " of " 
					+ convertEvt.totalSlides + " slides.";
			fileUploadWindow.progressBar.setProgress(convertEvt.completedSlides, convertEvt.totalSlides);
			fileUploadWindow.progressBar.validateNow();
		}
		
		private function handleExtractProgressEvent(note:INotification):void{
			var extractEvt:ProgressNotifier = note.getBody() as ProgressNotifier;

			fileUploadWindow.progressBar.label = "Extracting slide " + extractEvt.completedSlides + " of " 
					+ extractEvt.totalSlides + " slides.";
			fileUploadWindow.progressBar.setProgress(extractEvt.completedSlides, extractEvt.totalSlides);
			fileUploadWindow.progressBar.validateNow();
		}
		
		private function handleUpdateProgressEvent(note:INotification):void{
			fileUploadWindow.progressLbl.text = note.getBody() as String;
		}
		
		private function handleConvertSuccessEvent(note:INotification):void{
			log.debug("UploadMediator:: Convert Success " + note.getBody() as String);
			fileUploadWindow.okCancelBtn.label = "Ok";
			fileUploadWindow.okCancelBtn.visible = true;
			okState = true;
		}
		
		private function enableControls() : void
		{
			//First, remove this class from listening
			this.isListening = false;
			fileUploadWindow.okCancelBtn.visible = false;
			
			fileUploadWindow.selectBtn.enabled = true;
			fileUploadWindow.uploadBtn.enabled = true;
			fileUploadWindow.fileTxtInput.enabled = true;			
		}

	}
}