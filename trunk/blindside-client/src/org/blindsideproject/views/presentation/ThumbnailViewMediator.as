package org.blindsideproject.views.presentation
{
	import flash.events.Event;
	
	import org.bigbluebutton.modules.presentation.business.PresentationDelegate;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class ThumbnailViewMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ThumbnailViewMediator";
		public static const SEND_PAGE_NUM:String = "send page number";
		
		public function ThumbnailViewMediator(view:ThumbnailView)
		{
			super(NAME, view);
			thumbnailView.addEventListener(SEND_PAGE_NUM, sendPageNumber);
		}
		
		public function get thumbnailView():ThumbnailView{
			return viewComponent as ThumbnailView;
		}
		
		override public function listNotificationInterests():Array{
			return [];
		}
		
		override public function handleNotification(notification:INotification):void{
			
		}
		
		private function sendPageNumber(e:Event) : void {
			if ((thumbnailView.model.presentation.isPresenter) && (thumbnailView.model.presentation.isSharing)) {
				var pageNum : uint = thumbnailView.slideList.selectedIndex;
			
				proxy.gotoPage(pageNum);
			}
		}
		
		private function get proxy():PresentationDelegate{
			return facade.retrieveProxy(PresentationDelegate.ID) as PresentationDelegate;
		}

	}
}