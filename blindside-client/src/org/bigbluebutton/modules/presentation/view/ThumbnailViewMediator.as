package org.bigbluebutton.modules.presentation.view
{
	import flash.events.Event;
	
	import org.bigbluebutton.modules.presentation.model.business.PresentationDelegate;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	/**
	 * This class is the Mediator of the ThumbnailView GUI component
	 * <p>
	 * This class extends the Mediator class of the pureMVC framework 
	 * @author dzgonjan
	 * 
	 */	
	public class ThumbnailViewMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ThumbnailViewMediator";
		public static const SEND_PAGE_NUM:String = "send page number";
		
		/**
		 * The defauklt constructor. registers the gui component with this mediator 
		 * @param view
		 * 
		 */		
		public function ThumbnailViewMediator(view:ThumbnailView)
		{
			super(NAME, view);
			thumbnailView.addEventListener(SEND_PAGE_NUM, sendPageNumber);
		}
		
		/**
		 *  
		 * @return - the GUI component registered to this mediator
		 * 
		 */		
		public function get thumbnailView():ThumbnailView{
			return viewComponent as ThumbnailView;
		}
		
		/**
		 * Sends out a sendPageNumber notification 
		 * @param e
		 * 
		 */		
		private function sendPageNumber(e:Event) : void {
			if ((thumbnailView.model.presentation.isPresenter) && (thumbnailView.model.presentation.isSharing)) {
				var pageNum : uint = thumbnailView.slideList.selectedIndex;
			
				proxy.gotoPage(pageNum);
			}
		}
		
		/**
		 *  
		 * @return - the PresentationDelegate proxy of the Presentation Module
		 * 
		 */		
		private function get proxy():PresentationDelegate{
			return facade.retrieveProxy(PresentationDelegate.ID) as PresentationDelegate;
		}

	}
}