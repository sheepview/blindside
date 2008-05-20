package org.blindsideproject.views.presentation
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import org.blindsideproject.core.apps.presentation.model.PresentationFacade;
	import org.blindsideproject.main.BlindsideAppLocator;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class PresentationWindowMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "PresentationWindowMediator";
		
		public function PresentationWindowMediator(view:PresentationWindow)
		{
			super(NAME, view);
			presentationWindow.addEventListener(PresentationPanelMediator.CONNECT, connectToPresentation);
			presentationWindow.addEventListener(PresentationPanelMediator.SHARE, sharePresentation);
			presentationWindow.addEventListener(PresentationPanelMediator.OPEN_UPLOAD, openFileUploadWindow);
		}
		
		public function get presentationWindow():PresentationWindow{
			return viewComponent as PresentationWindow;
		}
		
		override public function listNotificationInterests():Array{
			return [
					PresentationFacade.READY_EVENT,
					PresentationFacade.VIEW_EVENT
					];
		}
		
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
		
		private function handleReadyEvent():void{
			presentationWindow.thumbnailView.visible = false;
				
			BlindsideAppLocator.getInstance().presentationApp.loadPresentation();	
		}
		
		private function handleViewEvent():void{
			presentationWindow.log.debug("Received viewEvent....");
				
			presentationWindow.thumbnailView.visible = true;
		}
		
		private function connectToPresentation(e:Event) : void{
			if (presentationWindow.model.presentation.isConnected) {
				BlindsideAppLocator.getInstance().presentationApp.leave();
			} else {
				BlindsideAppLocator.getInstance().presentationApp.join();					
			}
		}
		
		private function sharePresentation(e:Event) : void{
			if (presentationWindow.model.presentation.isSharing) {
				BlindsideAppLocator.getInstance().presentationApp.sharePresentation(false);
				presentationWindow.uploadPres.enabled = true;	
			} else {
				BlindsideAppLocator.getInstance().presentationApp.sharePresentation(true);
				presentationWindow.uploadPres.enabled = false;				
			}
		}
		
		private function openFileUploadWindow(e:Event) : void{
            presentationWindow.uploadWindow = FileUploadWindow(PopUpManager.createPopUp( this, FileUploadWindow, false));
			
			var point1:Point = new Point();
            // Calculate position of TitleWindow in Application's coordinates. 
            point1.x = presentationWindow.thumbnailView.x;
            point1.y = presentationWindow.thumbnailView.y;                
            point1 = presentationWindow.thumbnailView.localToGlobal(point1);
            presentationWindow.uploadWindow.x = point1.x + 25;
            presentationWindow.uploadWindow.y = point1.y + 25;
        }	

	}
}