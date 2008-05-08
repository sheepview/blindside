package model
{
	import flash.events.SyncEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.net.SharedObject;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import red5.as3.net.Connection;
	import red5.as3.net.events.ConnectionEvent;
	
	/**
	 * The LogInProxy is a delagate class that communicates between the red5 server-side Login application and
	 * the Flex client.
	 * @author dzgonjan
	 * 
	 */	
	public class LogInProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "Draw Proxy";
		public static const DEFAULT_RED5:String = "rtmp://134.117.58.92/login";
		
		private var conn:Connection;
		private var nc:NetConnection;
		private var loginSO:SharedObject;
		private var uri:String;
		
		/**
		 * The default constructor. Initializes the Connection and the red5 NetConnection class, which
		 * interacts with the red5 server.		 * 
		 */		
		public function LogInProxy()
		{
			super(NAME);
			conn = new Connection;
			this.uri = LogInProxy.DEFAULT_RED5;
			conn.addEventListener(Connection.SUCCESS, handleSucessfulConnection);
			conn.addEventListener(Connection.FAILED, handleConnectionFailed);
			conn.addEventListener(Connection.DISCONNECTED, handleDisconnection);
			conn.setURI(this.uri);
			conn.connect();
		}
		
		/**
		 * Handles a successful connection to the red5 server 
		 * @param e The connection event passed to the method
		 * 
		 */		
		public function handleSucessfulConnection(e:ConnectionEvent):void{
			nc = conn.getConnection();
			loginSO = SharedObject.getRemote("loginSO", uri, false);
            loginSO.addEventListener(SyncEvent.SYNC, sharedObjectSyncHandler);
            loginSO.client = this;
            loginSO.connect(nc);
		}
		
		/**
		 * If the Proxy is unable to connect to the Red5 server, this event will be called 
		 * @param e The ConnectionEvent which was passed in upon unsucessful connection attempt
		 * 
		 */		
		public function handleConnectionFailed(e:ConnectionEvent):void{
			//sendNotification(LogInFacade.FAILED_CONNECTION);
		}
		
		/**
		 * Once a shared object is created, it is synced accross all clients, and this method is invoked 
		 * @param e The sync event passed to the method
		 * 
		 */		
		public function sharedObjectSyncHandler(e:SyncEvent):void{
			
		}
		
		/**
		 * Handles a disconnection event
		 * @param e The dissconection event passed to the function
		 * 
		 */		
		public function handleDisconnection(e:ConnectionEvent):void{
			//sendNotification(LogInFacade.FAILED_CONNECTION);
		}
		
		/**
		 * Contacts the server-side application with a request to authenticate the user name and password 
		 * @param usrName - the user name to be passed to the server
		 * @param usrPass - the password to be passed to the server
		 * 
		 */		
		public function attempLogin(usrName:String, usrPass:String):void{
			if (conn != null && nc != null){
				nc.call("attemptLogin",new Responder(gotLoginResult, callFailed),usrName,usrPass);
			} else {
				sendNotification(LogInFacade.NOT_CONNECTED);
			}
		}
		
		public function attemptRegister(usrName:String, usrPass:String):void{
			if (conn != null && nc != null){
				nc.call("attemptRegister", new Responder(gotRegisterResult, callFailed), usrName, usrPass);
			} else {
				sendNotification(LogInFacade.NOT_CONNECTED);
			}
		}
		
		/**
		 * If the call to the server was successful, the server will call-back this method to show whether the
		 * user name and matching password exist or not 
		 * @param result - the boolean indicating whether the login was authenticated
		 * 
		 */		
		public function gotLoginResult(result:Object):void{
			sendNotification(LogInFacade.LOGIN_ATTEMPT, result);
		}
		
		public function gotRegisterResult(result:Object):void{
			sendNotification(LogInFacade.REGISTER_ATTEMPT, result);
		}
		
		/**
		 * If the call to the server failed this function will be called 
		 * @param fault - The reason the call could not be made
		 * 
		 */		
		public function callFailed(fault:Object):void{
			sendNotification(LogInFacade.CALL_FAILED, fault);
		}
	}
}