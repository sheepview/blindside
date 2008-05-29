package org.bigbluebutton.modules.chat.model.business
{
	import flash.events.SyncEvent;
	import flash.net.NetConnection;
	import flash.net.SharedObject;
	
	import org.bigbluebutton.modules.chat.ChatFacade;
	import org.bigbluebutton.modules.chat.model.vo.*;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	
	
	/**
	 * 
	 * This class gets a NetConnection instance and a shared object which try to connect.
	 * 
	 */
	public class ChatProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "Chat Proxy";
		public static const uri:String = "rtmp://134.117.58.96/oflaDemo";
		private var uri:String;		
		private var conn:Connection;
		private var nc:NetConnection;
		private var chatSO : SharedObject;
		
		
		
		/**
		 * This method makes a new connection and adds event listeners to it 
		 * @param messageVO
		 * 
		 */
		public function ChatProxy(messageVO:MessageVO)
		{
			super(NAME, messageVO);
			conn = new Connection;

			conn.addEventListener(Connection.SUCCESS, handleSucessfulConnection);
			conn.addEventListener(Connection.DISCONNECTED, handleDisconnection);
			conn.setURI(this.uri);
			conn.connect();
			
		}
	
		/**
		 * 
		 * @return the messageVO containig the message Object
		 * 
		 */
		public function get messageVO():MessageVO{
			return this.data as MessageVO;
		}
		
		/**
		 * Handles the event of successful connection
		 * @param e:ConnectionEvent
		 * 
		 */		
		public function handleSucessfulConnection(e:ConnectionEvent):void{
			nc = conn.getConnection();
			chatSO = SharedObject.getRemote("messageSO", uri, false);
            chatSO.addEventListener(SyncEvent.SYNC, sharedObjectSyncHandler);
            chatSO.client = this;
            chatSO.connect(nc);
            
		}
		public function handleDisconnection(e:ConnectionEvent):void {
			
		}		
		/**
		 * SyncHandler for Shared Object
		 * @param e:SyncEvent
		 * 
		 */
		public function sharedObjectSyncHandler(e:SyncEvent):void{
			
		}
		
		
		
		/**
		 * Sends the message to the shared object 
		 * @param message of type MessageVO
		 * 
		 */
		public function sendMessageToSharedObject(message:MessageObject):void{
			chatSO.send("receiveNewMessage", message.getMessgae(), message.getColor());
		}
		
		/**
		 * Updates the message VO according to the new message received
		 * and sends a notification for update the view
		 * @param message
		 * @param color
		 * 
		 */		
		public function receiveNewMessage(message:String , color:uint):void{
			var m:MessageObject = new MessageObject(message, color);
			this.messageVO.message = m;
			sendNotification(ChatFacade.NEW_MESSAGE, m);
		   
		}
		
		public function getSharedObject(): SharedObject {
			return chatSO;
		}
	}
}