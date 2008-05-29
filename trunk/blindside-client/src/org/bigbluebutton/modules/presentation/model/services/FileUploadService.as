package org.bigbluebutton.modules.presentation.model.services
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import org.bigbluebutton.modules.presentation.PresentationFacade;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	/**
	 * The FileUploadService receives and responds to events related to uploading files
	 * <p>
	 * This class extends the Proxy class of the pureMVC framework
	 * @author Richard Alam
	 * 
	 */	
	public class FileUploadService extends Proxy implements IProxy
	{
		public static const ID:String = "FileUploadService";
		
		private var request : URLRequest = new URLRequest();
		private var sendVars : URLVariables = new URLVariables();
		
		/**
		 * The default constructor 
		 * @param url - the address of the server
		 * @param room - a room in the server we're connecting to
		 * 
		 */		
		public function FileUploadService(url : String, room : String) : void
		{
			super(ID);
			sendVars.room = room;	
			request.url = url;
			request.data = sendVars;
		}
		
		/**
		 * Uploads local files to a server 
		 * @param file - The FileReference class of the file we wish to send
		 * 
		 */		
		public function upload(file : FileReference) : void
		{
			var fileToUpload : FileReference = new FileReference();
			fileToUpload = file;
			
			fileToUpload.addEventListener(ProgressEvent.PROGRESS, onUploadProgress);
			fileToUpload.addEventListener(Event.COMPLETE, onUploadComplete);
			fileToUpload.addEventListener(IOErrorEvent.IO_ERROR, onUploadIoError);
			fileToUpload.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onUploadSecurityError);
			
			// "pres" is the variable name of the uploaded file in the server
			fileToUpload.upload(request, "pres", false);	
		}
		
		/**
		 * Receives an ProgressEvent which then updated the progress bar on the view 
		 * @param event - a ProgressEvent
		 * 
		 */		
		private function onUploadProgress(event : ProgressEvent) : void
		{
			var percentage : Number = Math.round((event.bytesLoaded / event.bytesTotal) * 100);
			sendNotification(PresentationFacade.UPLOAD_PROGRESS_EVENT, percentage);
		}
		
		/**
		 * Method is called when the upload has completed successfuly 
		 * @param event
		 * 
		 */		
		private function onUploadComplete(event : Event) : void
		{
			sendNotification(PresentationFacade.UPLOAD_COMPLETED_EVENT);
		}

		/**
		 * Receives an ErrorEvent when an error occured during the upload 
		 * @param event
		 * 
		 */
		private function onUploadIoError(event : IOErrorEvent) : void
		{
			sendNotification(PresentationFacade.UPLOAD_IO_ERROR_EVENT, event.text);
		}
		
		/**
		 * Method is called when a SecurityError is received 
		 * @param event
		 * 
		 */		
		private function onUploadSecurityError(event : SecurityErrorEvent) : void
		{
			sendNotification(PresentationFacade.UPLOAD_SECURITY_ERROR_EVENT, event.text);
		}		
	}
}