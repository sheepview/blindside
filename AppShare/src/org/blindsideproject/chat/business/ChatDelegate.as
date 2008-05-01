package org.blindsideproject.chat.business
{
	
	import com.adobe.cairngorm.business.ServiceLocator;
	import flash.events.*;
	import flash.net.*;
	import flash.net.SharedObject;
	
	import mx.rpc.IResponder;
	
	import org.blindsideproject.chat.model.*;
	import org.blindsideproject.chat.vo.ChatVO;
		
	public class ChatDelegate implements IResponder
	{			
		private var model : ChatModelLocator = ChatModelLocator.getInstance();
		private var responder : IResponder;	
		private var service : Object;
		private var chat : Chat = model.chat;
		private var chatVO : ChatVO = model.chatVO
		private var netConnection : NetConnection = chat.nc;
		private var soChat:SharedObject;
		private var uri : String = "rtmp://localhost/fitcDemo";
					
		public function ChatDelegate(uri : String)
		{			
			this.uri = uri;
			
			connect();
		}
				
		public function connect() : void
		{		
			chat.nc = new NetConnection();
			chat.nc.client = this;
			chat.nc.connect(uri);

		}
		
		private function connectToChat() : void
		{
			NetConnection.defaultObjectEncoding = flash.net.ObjectEncoding.AMF0;
			SharedObject.defaultObjectEncoding  = flash.net.ObjectEncoding.AMF0;				
			
			soChat = SharedObject.getRemote( "videoConferenceChat", uri, true );
			soChat.addEventListener( NetStatusEvent.NET_STATUS, netStatusHandler );
			soChat.addEventListener( AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler );
			soChat.addEventListener( SyncEvent.SYNC, sharedObjectSyncHandler );
			soChat.client = this;
			soChat.connect( chat.nc );				
		}
		
		
		public function close() : void
		{
			soChat.close();
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
               
 //             connectToChat();
              


          }

          //-------------------------------------------------------------------------

          public function fault( event : Object ) : void
          {
              // Alert.show(event.fault);
          }
		
		
		public function sendMessage ( msg:String ):void
		{
			soChat.send("newMessage", msg );
		}
		
        public function newMessage ( msg:String ):void
        {        	
        	model.chatVO.message += msg + "\n";
        }
        
		/**
	 	*  Callback setID from server
	 	*/
		public function setId( id:Number ):*
		{
//			log.debug( "NetconnectionDelegate::setId: id=" + id );
			if( isNaN( id ) ) return;
//			connectionId = id;
			connectToChat();
			return "Okay";
		}	        
    }
}