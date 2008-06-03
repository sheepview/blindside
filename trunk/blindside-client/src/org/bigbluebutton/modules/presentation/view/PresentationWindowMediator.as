package org.bigbluebutton.modules.presentation.view
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.managers.PopUpManager;
	
	import org.bigbluebutton.modules.presentation.PresentationFacade;
	import org.bigbluebutton.modules.presentation.model.PresentationApplication;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	/**
	 * This class is a Mediator class of the PresentationWindow GUI component 
	 * @author dzgonjan
	 * 
	 */	
	public class PresentationWindowMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "PresentationWindowMediator";
		
		public static const CONNECT:String = "Connect to Presentation";
		public static const SHARE:String = "Share Presentation";
		public static const OPEN_UPLOAD:String = "Open File Upload Window"
		
		/**
		 * The constructor. Registers the view component with this mediator 
		 * @param view
		 * 
		 */		
		public function PresentationWindowMediator(view:PresentationWindow)
		{
			super(NAME, view);
			view.addEventListener(CONNECT, connectToPresentation);
			view.addEventListener(SHARE, sharePresentation);
			view.addEventListener(OPEN_UPLOAD, openFileUploadWindow);
		}
		
		/**
		 *  
		 * @return - the gui component contained in this mediator
		 * 
		 */		
		public function get presentationWindow():PresentationWindow{
			return viewComponent as PresentationWindow;
		}
		
		/**
		 *  
		 * @return A list of the notifications this class listens to
		 * This class listens to:
		 * 	PresentationFacade.READY_EVENT
		 * 	PresentationFacade.VIEW_EVENT
		 * 
		 */		
		override public function listNotificationInterests():Array{
			return [
					PresentationFacade.READY_EVENT,
					PresentationFacade.VIEW_EVENT
					];
		}
		
		/**
		 * Handles a received notification 
		 * @param notification
		 * 
		 */		
		override public function handleNotification(notification:INotification):void{
			switch(notification.getName()){
				case PresentationFacade.READY_EVENT:
					handleReadyEvent();
					break;
				case PresentationFacade.VIEW_EVENT:
					handleViewEvent();
					break;
			}
		}
		
		/**
		 * Handles a received Ready notification 
		 * 
		 */		
		private function handleReadyEvent():void{
			presentationWindow.thumbnailView.visible = false;
		}
		
		/**
		 * Handles a received View notification 
		 * 
		 */		
		private function handleViewEvent():void{
			presentationWindow.log.debug("Received viewEvent....");
				
			presentationWindow.thumbnailView.visible = true;
		}
		
		/**
		 * Attemps to conenct to the presentation on the server 
		 * @param e
		 * 
		 */		
		private function connectToPresentation(e:Event) : void{
			if (presentationWindow.model.presentation.isConnected) {
				sendNotification(PresentationApplication.LEAVE);
			} else {
				sendNotification(PresentationApplication.JOIN);				
			}
		}
		
		/**
		 * Share a presentation with the rest of the room on the server 
		 * @param e
		 * 
		 */		
		private function sharePresentation(e:Event) : void{
			if (presentationWindow.model.presentation.isSharing) {
				sendNotification(PresentationApplication.SHARE, false);
				presentationWindow.uploadPres.enabled = true;	
			} else {
				sendNotification(PresentationApplication.SHARE, true);
				presentationWindow.uploadPres.enabled = false;				
			}
		}
		
		/**
		 * Opens the file upload window in order to upload slides 
		 * @param e
		 * 
		 */		
		private function openFileUploadWindow(e:Event) : void{
            presentationWindow.uploadWindow = FileUploadWindow(PopUpManager.createPopUp( presentationWindow, FileUploadWindow, false));
			
			var point1:Point = new Point();
            // Calculate position of TitleWindow in Application's coordinates. 
            point1.x = presentationWindow.thumbnailView.x;
            point1.y = presentationWindow.thumbnailView.y;                
            point1 = presentationWindow.thumbnailView.localToGlobal(point1);
            presentationWindow.uploadWindow.x = point1.x + 25;
            presentationWindow.uploadWindow.y = point1.y + 25;
            
            sendNotification(PresentationFacade.STARTUPLOADWINDOW, presentationWindow.uploadWindow);
        }	

	}
}