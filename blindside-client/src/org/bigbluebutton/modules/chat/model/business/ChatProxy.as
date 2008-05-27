package org.bigbluebutton.modules.chat.model.business
{
	import flash.events.SyncEvent;
	import flash.net.NetConnection;
	import flash.net.SharedObject;
	import org.bigbluebutton.modules.chat.model.vo.MessageVO;
	
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
		
				
		private var log : ILogger = model.log;
		private var chatSO : SharedObject;
		private var connDelegate : NetConnectionDelegate;
		
		
		/**
		 * This method makes a new connection and adds event listeners to it 
		 * @param messageVO
		 * 
		 */
		public function ChatProxy()
		{
			connDelegate = new NetConnectionDelegate(this);
		}
	
		/**
		 * 
		 * @return the messageVO containig the message Object
		 * 
		 */
		public function get messageVO():MessageVO{
			return this.data as MessageVO;
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
		
		/**
		 * SyncHandler for Shared Object
		 * @param e:SyncEvent
		 * 
		 */
		public function sharedObjectSyncHandler(e:SyncEvent):void{
			
		}
		
		/**
		 * Handles disconnection
		 * @param e:ConnectionEvent
		 * 
		 */
		public function handleDisconnection(e:ConnectionEvent):void{
			
		}
		
		/**
		 * Sends the message to the shared object 
		 * @param message of type MessageVO
		 * 
		 */
		public function sendMessageToSharedObject(message:MessageVO):void{
			
			messageSO.send("receiveNewMessage", message.message, message.color);
			
		}
		
		/**
		 * Updates the message VO according to the new message received
		 * and sends a notification for update the view
		 * @param message
		 * @param color
		 * 
		 */		
		public function receiveNewMessage(message:String , color:uint):void{
			var m:MessageVO = new MessageVO();
			m.message = message;
			m.color = color;
			
			sendNotification(ChatFacade.NEW_MESSAGE, m);
		   
		}
		
		public function getSharedObject(): SharedObject {
			return messageSO;
		}
	}
}