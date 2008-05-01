package org.blindsideproject.presentation.business
{
	import com.adobe.cairngorm.business.ServiceLocator;

	import flash.events.*;
	import flash.net.*;
	import flash.net.SharedObject;
	import mx.rpc.IResponder;
	import org.blindsideproject.util.components.logger.model.*;
	
	import org.blindsideproject.presentation.model.*;
	import org.blindsideproject.presentation.vo.PresentationVO;
	public class PresentationDelegate implements IResponder
	{
		private var model : PresentationModelLocator = PresentationModelLocator.getInstance();
		private var responder : IResponder;	
		private var service : Object;
		private var presentation : Presentation = model.presentation;
		private var presentationVO : PresentationVO = model.presentationVO
		private var netConnection : NetConnection = presentation.nc;
		private var presentationSO:SharedObject = new SharedObject();
		private var uri : String = "rtmp://localhost/fitcDemo";
		private var log : Logger = model.getLogger();
		
		public function PresentationDelegate(uri : String)
		{			
			log.info("delegate constructor");
			
			this.uri = uri;

			connect();
		}
				
		public function connect() : void
		{		
			presentation.nc = new NetConnection();
			presentation.nc.client = this;
			presentation.nc.connect(uri);
			log.info("connect to net");
			connectToPresentation();
        }
        
        private function connectToPresentation() : void
		{
			log.info("Start");
			NetConnection.defaultObjectEncoding = flash.net.ObjectEncoding.AMF0;
			SharedObject.defaultObjectEncoding  = flash.net.ObjectEncoding.AMF0;				
			
			presentationSO = SharedObject.getRemote( "presentationSO", uri, true );
			presentationSO.addEventListener( NetStatusEvent.NET_STATUS, netStatusHandler );
			presentationSO.addEventListener( AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler );
			presentationSO.addEventListener( SyncEvent.SYNC, sharedObjectSyncHandler );
			presentationSO.client = this;
			presentationSO.connect( presentation.nc );	
					
		}
		
		
		public function close() : void
		{
			presentationSO.close();
			netConnection.close();
		}
		
		
		private function sharedObjectSyncHandler( event:SyncEvent ):void
			{		
//				Logger.debug( "sharedObjectSyncHandler:code: " + event.changeList );
			}

		private function netStatusHandler( event:NetStatusEvent ):void
			{
//				Logger.debug( "netStatusHandler:code: " + event.info.code );
			}
			
		private function asyncErrorHandler( event:AsyncErrorEvent ):void
			{
//				Logger.debug( "asyncErrorHandler:code: " + event.error );
			}			

		
		
		public function result( event : Object ) : void
           {
              // connectToPresentation();
               
               //presentation.goToPageNumberEvent();
           }

          //-------------------------------------------------------------------------

        public function fault( event : Object ) : void
          {
//             Alert.show(event.fault);
          }
          
        
        
        public function sendPageNumber ( pgn:Number ):void
		{
			log.info("befor send");
			presentationSO.send("newPageNumber", pgn );
			log.info("after send");
			log.debug("page: "+ pgn + "\n");
		}
		
        public function newPageNumber ( page:Number ):void
        {        	
        	model.presentationVO.pageNumber = page;
        	log.debug("model.presentationVO.pageNumber" + model.presentationVO.pageNumber);
        	presentation.goToPageNumberEvent(page);
        } 
        
        //public function setID( id:Number ):*
		//{
//			log.debug( "NetconnectionDelegate::setId: id=" + id );
		//	if( isNaN( id ) ) return;
//			connectionId = id;
		//	connectToChat();
		//	return "Okay";
		//}	     
		
	}
}