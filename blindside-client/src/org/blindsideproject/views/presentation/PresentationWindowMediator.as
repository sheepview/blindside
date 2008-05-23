package org.blindsideproject.views.presentation
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.managers.PopUpManager;
	
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
			view.addEventListener(PresentationPanelMediator.CONNECT, connectToPresentation);
			view.addEventListener(PresentationPanelMediator.SHARE, sharePresentation);
			view.addEventListener(PresentationPanelMediator.OPEN_UPLOAD, openFileUploadWindow);
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
				
			BlindsideAppLocator.getInstance().presentationFacade.presentationApp.loadPresentation();	
		}
		
		private function handleViewEvent():void{
			presentationWindow.log.debug("Received viewEvent....");
				
			presentationWindow.thumbnailView.visible = true;
		}
		
		private function connectToPresentation(e:Event) : void{
			if (presentationWindow.model.presentation.isConnected) {
				BlindsideAppLocator.getInstance().presentationFacade.presentationApp.leave();
			} else {
				BlindsideAppLocator.getInstance().presentationFacade.presentationApp.join();					
			}
		}
		
		private function sharePresentation(e:Event) : void{
			if (presentationWindow.model.presentation.isSharing) {
				BlindsideAppLocator.getInstance().presentationFacade.presentationApp.sharePresentation(false);
				presentationWindow.uploadPres.enabled = true;	
			} else {
				BlindsideAppLocator.getInstance().presentationFacade.presentationApp.sharePresentation(true);
				presentationWindow.uploadPres.enabled = false;				
			}
		}
		
		private function openFileUploadWindow(e:Event) : void{
            presentationWindow.uploadWindow = FileUploadWindow(PopUpManager.createPopUp( presentationWindow, FileUploadWindow, false));
			
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