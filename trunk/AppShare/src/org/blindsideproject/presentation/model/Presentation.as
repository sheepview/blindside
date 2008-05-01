package org.blindsideproject.presentation.model
{
	import flash.net.*;
	import org.blindsideproject.presentation.business.PresentationDelegate;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import org.blindsideproject.presentation.control.PresentationController;
	import org.blindsideproject.presentation.events.GotoPageNumberEvent;
	
	public class Presentation
	{
		public var nc : NetConnection;
		public var presentationDelegate : PresentationDelegate;
		public var uri : String = "rtmp://localhost/SOSample";
		public var dispatcher : CairngormEventDispatcher = CairngormEventDispatcher.getInstance();

		private var fileUploadUri : String;
		private var slideDisplayUri : String;
		private var room : String;
		private var fileUploadHost : String;
		
		private var role : uint;
		
		public function Presentation() {}
		
		public function setupConnection() : void
		{
			presentationDelegate = new PresentationDelegate(uri);
		}
		
		public function goToPageNumberEvent(page : Number) : void
		{
			var event : GotoPageNumberEvent = new GotoPageNumberEvent(page);
			dispatcher.dispatchEvent(event);
		}
		
		public function setFileUploadHost(uploadHost : String) : void
		{
			this.fileUploadHost = uploadHost;
		}
		
		public function getFileUploadHost() : String
		{
			return fileUploadHost;
		}
		
		public function setFileUploadUri(uploadUri : String) : void
		{
			this.fileUploadUri = uploadUri;
		}
		
		public function getFileUploadUri() : String
		{
			return fileUploadUri;
		}		

		public function setSlideDisplayUri(displayUri : String) : void
		{
			this.slideDisplayUri = displayUri;
		}
		
		public function getSlideDisplayUri() : String
		{
			return slideDisplayUri;
		}	
		
		public function setRoom(room : String) : void
		{
			this.room = room;
		}
		
		public function getRoom() : String{
			return room;
		}
		
		public function setRole(role : uint) : void
		{
			this.role = role;
		}
		
		public function getRole() : uint
		{
			return role;
		}
	}
}