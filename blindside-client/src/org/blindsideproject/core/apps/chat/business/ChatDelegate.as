package org.blindsideproject.core.apps.chat.business
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import flash.events.*;
	import flash.net.*;
	import flash.net.SharedObject;
	
	import mx.rpc.IResponder;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import org.blindsideproject.core.apps.chat.model.*;
	import org.blindsideproject.core.apps.chat.vo.MessageVO;
	import org.blindsideproject.core.util.log.*;
	import org.blindsideproject.core.apps.conference.model.ConferenceModelLocator;
	import org.blindsideproject.core.apps.conference.model.ConferenceModel;
	import org.blindsideproject.core.apps.chat.controller.events.*;
	
		
	public class ChatDelegate
	{			
		public static const ID : String = "ChatDelegate";
		
		private var model : ChatModelLocator = ChatModelLocator.getInstance();
		private var cModel : ConferenceModelLocator = ConferenceModelLocator.getInstance();
		private var dispatcher : CairngormEventDispatcher = model.dispatcher;	
		private var log : ILogger = model.log;
		private var chat : ChatModel = model.chat;
//		private var conference : ConferenceModel = cModel.conference;
		private var chatSO : SharedObject;
		private var connDelegate : NetConnectionDelegate;
		//private var toUseridPrivateMessageVO : PrivateMessageVO  = new PrivateMessageVO("");
		
		
					
		public function ChatDelegate()
		{			
			connDelegate = new NetConnectionDelegate(this);
		}
				
		public function connectionSuccess() : void
		{
			chat.connected = true;
			
			sendConnectedEvent();
			
			joinConference();
		}
			
		public function connectionFailed(message : String) : void 
		{
			if (chatSO != null) chatSO.close();
			
			chat.connected = false;
			
			sendDisconnectedEvent(message);
		}		
		
		public function join(host : String, room : String) : void
		{			
			chat.host = host;			
			connDelegate.connect(host, room);
		}
		
		public function leave() : void
		{
			
			removeListeners();
			chatSO.close(); 
			log.info("chatSO.close();");
			connDelegate.disconnect();
			model.chat.messageVO.message = "";	
					
		}
				
		private function joinConference() : void
		{
			chatSO = SharedObject.getRemote("chatSO", connDelegate.connUri, true);
			chatSO.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			chatSO.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			chatSO.addEventListener(SyncEvent.SYNC, sharedObjectSyncHandler);
			
			chatSO.client = this;

			chatSO.connect(connDelegate.getConnection());
			
			// Query who are the participants within this conference
			//chatSO.send("getParticipants");
		}
		
		private function removeListeners() : void
		{
			log.info("Removing Listeners...");
			chatSO.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			chatSO.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			chatSO.removeEventListener(SyncEvent.SYNC, sharedObjectSyncHandler);
		}	 
		
		
		private function sharedObjectSyncHandler( event:SyncEvent ):void
		{		
            log.debug( "CHAT::sharedObjectSyncHandler " + event.changeList);
		}

		private function netStatusHandler( event:NetStatusEvent ):void
		{
			log.debug( "CHAT::netStatusHandler:code: " + event.info.code );
		}
			
		private function asyncErrorHandler( event:AsyncErrorEvent ):void
		{
			log.debug( "CHAT::asyncErrorHandler:code: " + event.error );
		}			


		public function sendMessage ( msg:String ):void
		{
			chatSO.send("newMessage", msg );
		}
		
        public function newMessage ( msg:String ):void
        {        	
        	model.chat.messageVO.message += msg + "\n";
        }
        
        public function openPrivateChatPanel(toUserid : Number):void
        {
        	chatSO.send("newPrivateChatPanel" , toUserid);
        }
        
        public function newPrivateChatPanel(toUserid : Number):void
        {
        	//model.chat.privateMessageVO.toUserid = toUserid;
        	//model.chat.privateChats.addItem(model.chat.privateMessageVO);
        	
        }
        
        public function sendPrivateMessage ( pMsg : String , fromUserid : Number ,
         toUserid : Number , fromUsername : String , toUsername : String , initiator : Boolean):void
        {
        	chatSO.send("newPrivateMessage" , pMsg , fromUserid , toUserid , fromUsername , toUsername , initiator);
        }
        

        public function newPrivateMessage (pMsg : String , fromUserid : Number , 
        toUserid : Number , fromUsername : String , toUsername : String , initiator : Boolean):void

        {
            
            if(toUserid == cModel.conference.me.userid)
            {
            	
            	var chatRequest : NewChatRequestEvent = new NewChatRequestEvent
			    (ChatEvents.NEW_CHAT_REQUEST_EVENT , fromUserid , toUserid , 
			    fromUsername , toUsername , pMsg , initiator);
			    dispatcher.dispatchEvent(chatRequest);
            }
            //sendPrivateChatRequest(pMsg , fromUserid , toUserid);       	
        }
        
        public function sendConnectedEvent() : void
		{
		}

		public function sendDisconnectedEvent(message : String):void
		{
		}
		//public function sendPrivateChatRequest(pMsg:String , fromUserid:Number , toUserid:Number):void
		//{
		//	var chatRequest : NewChatRequestEvent = new NewChatRequestEvent
		//	(ChatEvents.NEW_CHAT_REQUEST_EVENT , pMsg , fromUserid , toUserid);
		//	dispatcher.dispatchEvent(chatRequest);
		//}

    }
}