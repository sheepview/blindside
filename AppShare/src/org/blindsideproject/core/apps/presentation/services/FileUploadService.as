package org.blindsideproject.core.apps.presentation.services
{
	import flash.net.URLVariables;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import org.blindsideproject.core.apps.presentation.controller.events.UploadProgressEvent;
	import org.blindsideproject.core.apps.presentation.controller.events.UploadCompletedEvent;
	import org.blindsideproject.core.apps.presentation.controller.events.UploadIoErrorEvent;
	import org.blindsideproject.core.apps.presentation.controller.events.UploadSecurityErrorEvent;	
	
	public class FileUploadService
	{
		private var request : URLRequest = new URLRequest();
		private var sendVars : URLVariables = new URLVariables();
		
		public function FileUploadService(url : String, room : String) : void
		{
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
			var progEvent : UploadProgressEvent = new UploadProgressEvent(percentage);
			progEvent.dispatch();
		}
		
		private function onUploadComplete(event : Event) : void
		{
			var completeEvent : UploadCompletedEvent = new UploadCompletedEvent();
			completeEvent.dispatch();
		}

		private function onUploadIoError(event : IOErrorEvent) : void
		{
			var ioErrorEvent : UploadIoErrorEvent = new UploadIoErrorEvent(event.text);
			ioErrorEvent.dispatch();
		}
		
		private function onUploadSecurityError(event : SecurityErrorEvent) : void
		{
			var secErrorEvent : UploadSecurityErrorEvent = new UploadSecurityErrorEvent(event.text);
			secErrorEvent.dispatch();
		}		
	}
}