package model
{
	import business.*;
	
	import flash.events.SyncEvent;
	import flash.net.NetConnection;
	import flash.net.SharedObject;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	

	/**
	 * 
	 * @author snegari
	 * 
	 */
	public class TestProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "Test Proxy";
		public static const DEFAULT_RED5:String = "rtmp://134.117.58.96/conference";
		
		private var conn:Connection;
		private var nc:NetConnection;
		private var uri:String;
		private var testSO : SharedObject;
		
		
		/**
		 * This method makes a new connection and adds event listeners to it 
		 * @param messageVO
		 * 
		 */
		public function TestProxy(conference:Conference)
		{
			super(NAME, conference);
			conn = new Connection;
			this.uri = TestProxy.DEFAULT_RED5;
			conn.addEventListener(Connection.SUCCESS, handleSucessfulConnection);
			conn.addEventListener(Connection.DISCONNECTED, handleDisconnection);
			conn.setURI(this.uri);
			conn.connect();
		}
	
		public function get conference():Conference{
			return this.data as Conference;
		}
		/**
		 * 
		 * @return the messageVO containig the message Object
		 * 
		 */
		//public function get messageVO():MessageVO{
		//	return this.data as MessageVO;
		//}
		/**
		 * Handles the event of successful connection
		 * @param e:ConnectionEvent
		 * 
		 */		
		public function handleSucessfulConnection(e:ConnectionEvent):void{
			nc = conn.getConnection();
			testSO = SharedObject.getRemote("testSO", uri, false);
            testSO.addEventListener(SyncEvent.SYNC, sharedObjectSyncHandler);
            testSO.client = this;
            testSO.connect(nc);
            
		}
		
		/**
		 * SyncHandler for Shared Object
		 * @param e:SyncEvent
		 * 
		 */
		private function sharedObjectSyncHandler( event : SyncEvent) : void
		{
			//log.debug( "Conference::sharedObjectSyncHandler " + event.changeList.length);
			
			for (var i : uint = 0; i < event.changeList.length; i++) 
			{
				trace( "Conference::handlingChanges[" + event.changeList[i].name + "][" + i + "]");
				handleChangesToSharedObject(event.changeList[i].code, 
						event.changeList[i].name, event.changeList[i].oldValue);
			}
		}
		
		
		private function handleChangesToSharedObject(code : String, name : String, oldValue : Object) : void
		{
			switch (code)
			{
				case "clear":
					/** From flash.events.SyncEvent doc
					 * 
					 * A value of "clear" means either that you have successfully connected 
					 * to a remote shared object that is not persistent on the server or the 
					 * client, or that all the properties of the object have been deleted -- 
					 * for example, when the client and server copies of the object are so 
					 * far out of sync that Flash Player resynchronizes the client object 
					 * with the server object. In the latter case, SyncEvent.SYNC is dispatched 
					 * and the "code" value is set to "change". 
					 */
					 
					//conference.removeAllParticipants();
													
					break;	
																			
				case "success":
					/** From flash.events.SyncEvent doc
					 * 	 A value of "success" means the client changed the shared object. 		
					 */
					
					// do nothing... just log it 
					trace( "Conference::success =[" + name + "]");	
					break;

				case "reject":
					/** From flash.events.SyncEvent doc
					 * 	A value of "reject" means the client tried unsuccessfully to change the 
					 *  object; instead, another client changed the object.		
					 */
					
					// do nothing... just log it 
					// Or...maybe we should check if the value is the same as what we wanted it
					// to be..if not...change it?
					trace( "Conference::reject =[" + code + "," + name + "," + oldValue + "]");	
					break;

				case "change":
					/** From flash.events.SyncEvent doc
					 * 	A value of "change" means another client changed the object or the server 
					 *  resynchronized the object.  		
					 */
					 
					if (name != null) {						
						if (conference.hasParticipant(testSO.data[name].userid)) {
							var changedUser : User = conference.getParticipant(Number(name));
							//changedUser.status = testSO.data[name].status;
							//changedUser.hasStream = testSO.data[name].hasStream;
							//changedUser.streamName = testSO.data[name].streamName;	

							trace( "Conference::change =[" + 
								name + "," + changedUser.name  + "]");
																					
						} else {
							// The server sent us a new user.
							var user : User = new User(null,null);
							user.userid = testSO.data[name].userid;
							user.name = testSO.data[name].name;
							//user.status = testSO.data[name].status;
							//user.hasStream = testSO.data[name].hasStream;
							//user.streamName = testSO.data[name].streamName;							
							//user.role = testSO.data[name].role;						
							
							trace( "Conference::change::newuser =[" + 
								name + "," + user.name +   "]");
							
							conference.addUser(user);
						}
						
					} else {
						trace( "Conference::SO::change is null");
					}
																	
					break;

				case "delete":
					/** From flash.events.SyncEvent doc
					 * 	A value of "delete" means the attribute was deleted.  		
					 */
					
					trace( "Conference::delete =[" + code + "," + name + "," + oldValue + "]");	
					
					// The participant has left. Cast name (string) into a Number.
					//conference.removeParticipant(Number(name));
					break;
										
				default:	
					trace( "Conference::default[" + testSO.data[name].userid
									+ "," + testSO.data[name].name + "]");		 
					break;
			}
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
		public function sendMessage(user:User):void{
			//messageSO.data.aProperty = message.getMessgae();
			
			

			testSO.send("getMessage", user.userid, user.message);
			user.message = "A test event was sent to user with userid " + user.userid + "\n";
			sendNotification(ApplicationFacade.UPDATE, user);
			
		}
		
		/**
		 * Updates the messageObject according to the new message received
		 * and sends a notification for update 
		 * @param message
		 * @param color
		 * 
		 */		
		public function getMessage(userid:Number, message:String):void{
			var user:User = new User(userid,message);
			if(userid == conference.me.userid)
            {
            	
            	sendNotification(ApplicationFacade.UPDATE, user);
            	//var chatRequest : NewChatRequestEvent = new NewChatRequestEvent
			    //(ChatEvents.NEW_CHAT_REQUEST_EVENT , fromUserid , toUserid , 
			    //fromUsername , toUsername , pMsg , initiator);
			   // dispatcher.dispatchEvent(chatRequest);
            }
			
		   
		}
		
		public function getSharedObject(): SharedObject {
			return testSO;
		}
	}
}