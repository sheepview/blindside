package model
{
	import flash.events.SyncEvent;
	import flash.net.NetConnection;
	import flash.net.SharedObject;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import red5.as3.net.Connection;
	import red5.as3.net.events.ConnectionEvent;

	public class MessageProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "Message Proxy";
		public static const DEFAULT_RED5:String = "rtmp://134.117.58.96/test";
		
		private var conn:Connection;
		private var nc:NetConnection;
		private var messageSO:SharedObject;
		private var uri:String;
		
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
		
		public function get messageVO():MessageVO{
			return this.data as MessageVO;
		}
		
		public function handleSucessfulConnection(e:ConnectionEvent):void{
			nc = conn.getConnection();
			messageSO = SharedObject.getRemote("messageSO", uri, false);
            messageSO.addEventListener(SyncEvent.SYNC, sharedObjectSyncHandler);
            messageSO.client = this;
            messageSO.connect(nc);
		}
		
		public function sharedObjectSyncHandler(e:SyncEvent):void{
			
		}
		
		public function handleDisconnection(e:ConnectionEvent):void{
			
		}
		
		public function sendMessage(message:MessageObject):void{
			
			messageSO.send("addMessage", message.getMessgae(), message.getColor());
		}
		
		public function addMessage(message:String , color:uint):void{
			var m:MessageObject = new MessageObject(message, color);
			this.messageVO.message = m;
			sendNotification(ApplicationFacade.UPDATE, m);
		}
	}
}