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
	
	public class FileUploadService extends Proxy implements IProxy
	{
		public static const ID:String = "FileUploadService";
		
		private var request : URLRequest = new URLRequest();
		private var sendVars : URLVariables = new URLVariables();
		
		public function FileUploadService(url : String, room : String) : void
		{
			super(ID);
			sendVars.room = room;	
			request.url = url;
			request.data = sendVars;
		}
		
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
		
		private function onUploadProgress(event : ProgressEvent) : void
		{
			var percentage : Number = Math.round((event.bytesLoaded / event.bytesTotal) * 100);
			sendNotification(PresentationFacade.UPLOAD_PROGRESS_EVENT, percentage);
		}
		
		private function onUploadComplete(event : Event) : void
		{
			sendNotification(PresentationFacade.UPLOAD_COMPLETED_EVENT);
		}

		private function onUploadIoError(event : IOErrorEvent) : void
		{
			sendNotification(PresentationFacade.UPLOAD_IO_ERROR_EVENT, event.text);
		}
		
		private function onUploadSecurityError(event : SecurityErrorEvent) : void
		{
			sendNotification(PresentationFacade.UPLOAD_SECURITY_ERROR_EVENT, event.text);
		}		
	}
}