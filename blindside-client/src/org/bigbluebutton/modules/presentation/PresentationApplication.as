package org.bigbluebutton.modules.presentation
{
				
	import flash.net.FileReference;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.rpc.IResponder;
	import mx.utils.ArrayUtil;
	
	import org.bigbluebutton.modules.presentation.business.PresentationDelegate;
	import org.bigbluebutton.modules.presentation.model.PresentationFacade;
	import org.bigbluebutton.modules.presentation.model.PresentationModel;
	import org.bigbluebutton.modules.presentation.services.FileUploadService;
	import org.bigbluebutton.modules.presentation.services.PresentationService;
	import org.bigbluebutton.modules.presentation.vo.SlidesDeck;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
						
	public class PresentationApplication extends Mediator implements IMediator, IResponder
	{
		public var model:PresentationModel; 
		public static const NAME:String = "PresentationApplication";

		private var _url : String;
		private var _userid : Number;
		private var _room : String;
		private var _docServiceAddress : String = "http://localhost:8080";
		
		public function PresentationApplication(userid : Number, room : String, 
				url : String, docServiceAddress : String) : void 
		{
			super(NAME);
			_url = url;
			_userid = userid;
			_room = room;
			_docServiceAddress = docServiceAddress;
			
			// Initialize the model
			model = PresentationFacade.getInstance().presentation;
		}
		
		public function join() : void
		{	
			presentationProxy.join(_userid, _url, _room);		
		}
		
		public function get presentationProxy():PresentationDelegate{
			return facade.retrieveProxy(PresentationDelegate.ID) as PresentationDelegate;
		}
		
		public function leave() : void
		{
			presentationProxy.leave();
		}
		
		override public function listNotificationInterests():Array{
			return [
					];
		}
		
		override public function handleNotification(notification:INotification):void{
			//switch(notification.getName()){
			//}
		}
		
		public function uploadPresentation(fileToUpload : FileReference) : void
		{
			var fullUri : String = _docServiceAddress + "/blindside/file/upload";
						
			var service:FileUploadService = new FileUploadService(fullUri, _room);
			facade.registerProxy(service);
			service.upload(fileToUpload);
		}
		
		public function loadPresentation() : void
		{
			var fullUri : String = _docServiceAddress + "/blindside/file/xmlslides?room=" + _room;	
			model.presentationLoaded = false;
			
			var service:PresentationService = new PresentationService(fullUri, this);
		}
		
		public function sharePresentation(share : Boolean) : void
		{
			if (share) {	
				presentationProxy.share(true);		
			} else {
				presentationProxy.share(false);					
			}		
		}
		
		public function assignPresenter(userid : Number, name : String) : void
		{
			presentationProxy.givePresenterControl(userid, name);		
		}
		
		public function result(event : Object):void
		{
			//log.debug("Got result [" + event.result.toString() + "]");
		
			if (event.result.presentations == null)	return;
			
		    var result:ArrayCollection = event.result.presentations.presentation is ArrayCollection
		        ? event.result.presentations.presentation as ArrayCollection
		        : new ArrayCollection(ArrayUtil.toArray(event.result.presentations.presentation));
		    
		    var temp:ArrayCollection = new ArrayCollection();
		    var cursor:IViewCursor = result.createCursor();
		    
		    while (!cursor.afterLast)
		    {
		    	var deck:SlidesDeck = new SlidesDeck(cursor.current);
		    	//log.debug("Got gallery [" + deck.title + "]");
				model.newDeckOfSlides(deck);
		        cursor.moveNext();
		    }
		}

		public function fault(event : Object):void
		{
			//log.debug("Got fault [" + event.fault.toString() + "]");		
		}		
	}
}