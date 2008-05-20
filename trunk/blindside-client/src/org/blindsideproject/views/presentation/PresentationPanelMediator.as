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
	
	public class PresentationPanelMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "PresentationPanelMediator";
		public static const CONNECT:String = "Connect to Presentation";
		public static const SHARE:String = "Share Presentation";
		public static const OPEN_UPLOAD:String = "Open File Upload Window"
		
		public function PresentationPanelMediator(view:PresentationPanel)
		{
			super(NAME, view);
			presentationPanel.addEventListener(CONNECT, connectToPresentation);
			presentationPanel.addEventListener(SHARE, sharePresentation);
			presentationPanel.addEventListener(OPEN_UPLOAD, openFileUploadWindow);
		}
		
		protected function get presentationPanel():PresentationPanel{
			return viewComponent as PresentationPanel;
		}
		
		override public function listNotificationInterests():Array{
			return [
					PresentationFacade.CLEAR_EVENT,
					PresentationFacade.READY_EVENT,
					PresentationFacade.VIEW_EVENT
					];
		}
		
		override public function handleNotification(notification:INotification):void{
			switch(notification.getName()){
				case PresentationFacade.CLEAR_EVENT:
					handleClearEvent();
					break;
				case PresentationFacade.READY_EVENT:
					handleReadyEvent();
					break;
				case PresentationFacade.VIEW_EVENT:
					handleViewEvent();
					break;
			}
		}
		
		private function handleClearEvent():void{
			if (presentationPanel.model.presentation.isPresenter) return;
			
			presentationPanel.thumbnailView.visible = false;
		}
		
		private function handleReadyEvent():void{
			presentationPanel.thumbnailView.visible = false;
			BlindsideAppLocator.getInstance().presentationApp.loadPresentation();	
		}
		
		private function handleViewEvent():void{
			presentationPanel.log.debug("Received viewEvent....");
				
			presentationPanel.thumbnailView.visible = true;
		}
		
		private function connectToPresentation(e:Event) : void{
			if (presentationPanel.model.presentation.isConnected) {
				BlindsideAppLocator.getInstance().presentationApp.leave();
			} else {
				BlindsideAppLocator.getInstance().presentationApp.join();					
			}
		}
		
		private function sharePresentation(e:Event) : void{
			if (presentationPanel.model.presentation.isSharing) {
				BlindsideAppLocator.getInstance().presentationApp.sharePresentation(false);
				presentationPanel.uploadPres.enabled = true;	
			} else {
				BlindsideAppLocator.getInstance().presentationApp.sharePresentation(true);
				presentationPanel.uploadPres.enabled = false;				
			}
		}
		
		private function openFileUploadWindow(e:Event) : void{
            presentationPanel.uploadWindow = FileUploadWindow(PopUpManager.createPopUp( presentationPanel, FileUploadWindow, false));

			var point1:Point = new Point();
            // Calculate position of TitleWindow in Application's coordinates. 
            point1.x = presentationPanel.thumbnailView.x;
            point1.y = presentationPanel.thumbnailView.y;                
            point1 = presentationPanel.thumbnailView.localToGlobal(point1);
            presentationPanel.uploadWindow.x = point1.x + 25;
            presentationPanel.uploadWindow.y = point1.y + 25;
        }					

	}
}