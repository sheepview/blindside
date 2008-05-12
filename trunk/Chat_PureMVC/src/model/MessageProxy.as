package chat.model
{
	import flash.events.SyncEvent;
	import flash.net.NetConnection;
	import flash.net.SharedObject;
	import chat.ChatFacade;
	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	import util.red5.as3.net.Connection;
	import util.red5.as3.net.events.ConnectionEvent;

	/**
	 * 
	 * @author snegari
	 * 
	 */
	public class MessageProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "Message Proxy";
		public static const DEFAULT_RED5:String = "rtmp://134.117.58.96/oflaDemo";
		
		private var conn:Connection;
		private var nc:NetConnection;
		private var messageSO:SharedObject;
		private var uri:String;
		private var testSO : SharedObject;
		
		
		/**
		 * This method makes a new connection and adds event listeners to it 
		 * @param messageVO
		 * 
		 */
		public function MessageProxy(messageVO:MessageVO)
		{
			super(NAME, messageVO);
			conn = new Connection;
			this.uri = MessageProxy.DEFAULT_RED5;
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
			messageSO = SharedObject.getRemote("messageSO", uri, false);
            messageSO.addEventListener(SyncEvent.SYNC, sharedObjectSyncHandler);
            messageSO.client = this;
            messageSO.connect(nc);
            ////////////////////////////////
           // testSO = SharedObject.getRemote("messageSO", uri, false);
            //testSO.addEventListener(SyncEvent.SYNC, sharedObjectSyncHandler);
            //testSO.client = this;(messageSO);// = this;
            //testSO.connect(nc);
            
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
		 * @param message
		 * 
		 */
		public function sendMessage(message:MessageObject):void{
			//messageSO.data.aProperty = message.getMessgae();
			messageSO.send("addMessage", message.getMessgae(), message.getColor());
			
		}
		
		/**
		 * Updates the messageObject according to the new message received
		 * and sends a notification for update 
		 * @param message
		 * @param color
		 * 
		 */		
		public function addMessage(message:String , color:uint):void{
			var m:MessageObject = new MessageObject(message, color);
			this.messageVO.message = m;
			sendNotification(ChatFacade.UPDATE, m);
		   
		}
		
		public function getSharedObject(): SharedObject {
			return messageSO;
		}
	}
}