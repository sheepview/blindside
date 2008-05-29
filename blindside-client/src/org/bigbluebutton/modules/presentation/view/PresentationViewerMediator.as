package org.bigbluebutton.modules.presentation.view
{
	import flash.events.Event;
	
	import org.blindsideproject.core.apps.presentation.model.PresentationFacade;
	import org.blindsideproject.main.BlindsideAppLocator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class PresentationViewerMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "PresentationViewerMediator";
		
		public static const CONNECT:String = "Connect To Presentation";
		public static const SHARE:String = "Share Presentation";
		public static const OPEN_UPLOAD = "Open File Upload Window";
		
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		
		public function PresentationViewerMediator(view:PresentationViewer)
		{
			super(NAME, view);
			presentationViewer.addEventListener(CONNECT, connectToPresentation);
			presentationViewer.addEventListener(SHARE, sharePresentation);
			presentationViewer.addEventListener(OPEN_UPLOAD, openFileUploadWindow);
		}
		
		public function get presentationViewer():PresentationViewer{
			return viewComponent as PresentationViewer;
		}
		
		override public function listNotificationInterests():Array{
			return [
					PresentationFacade.CLEAR_EVENT,
					PresentationFacade.VIEW_EVENT,
					PresentationFacade.READY_EVENT
					];
		}
		
		override public function handleNotification(notification:INotification):void{
			switch(notification.getName()){
				case PresentationFacade.CLEAR_EVENT:
					handleClearEvent(notification);
					break;
				case PresentationFacade.VIEW_EVENT:
					handleViewEvent(notification);
					break;
				case PresentationFacade.READY_EVENT:
					handleReadyEvent(notification);
					break;
			}
		}
		
		private function handleClearEvent(note:INotification):void{
		// Don't clear our screen if we are the presenter
			if (presentationViewer.model.presentation.isPresenter) return;
			
			presentationViewer.thumbnailView.visible = false;
		}
		
		private function handleViewEvent(note:INotification):void{
			presentationViewer.log.debug("Received viewEvent....");
			presentationViewer.thumbnailView.visible = true;
		}
		
		private function handleReadyEvent(note:INotification):void{
			presentationViewer.thumbnailView.visible = false;
			BlindsideAppLocator.getInstance().presentationApp.loadPresentation();		
		}
		
		private function connectToPresentation(e:Event):void{
			if (presentationViewer.model.presentation.isConnected) {
				BlindsideAppLocator.getInstance().presentationApp.leave();
			} else {
				BlindsideAppLocator.getInstance().presentationApp.join();					
			}
		}
		
		private function sharePresentation(e:Event) : void{
			if (model.presentation.isSharing) {
				BlindsideAppLocator.getInstance().presentationApp.sharePresentation(false);
				presentationViewer.uploadPres.enabled = true;	
			} else {
				BlindsideAppLocator.getInstance().presentationApp.sharePresentation(true);
				presentationViewer.uploadPres.enabled = false;				
			}
		}
		
		private function openFileUploadWindow(e:Event) : void{
            presentationViewer.uploadWindow = FileUploadWindow(PopUpManager.createPopUp( this, FileUploadWindow, false));
			
			var point1:Point = new Point();
            // Calculate position of TitleWindow in Application's coordinates. 
            point1.x = presentationViewer.thumbnailView.x;
            point1.y = presentationViewer.thumbnailView.y;                
            point1 = presentationViewer.thumbnailView.localToGlobal(point1);
            presentationViewer.uploadWindow.x = point1.x + 25;
            presentationViewer.uploadWindow.y = point1.y + 25;
        }	

	}
}