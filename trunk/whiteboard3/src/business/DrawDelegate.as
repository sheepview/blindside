package business
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import control.event.UpdateEvent;
	
	import flash.events.SyncEvent;
	import flash.net.NetConnection;
	import flash.net.SharedObject;
	
	import model.DrawModel;
	import model.DrawModelLocator;
	
	import org.red5.as3.net.Connection;
	import org.red5.as3.net.events.ConnectionEvent;
	
	/**
	 * A Service Delegate class. Abstracts a web service for the application to use.
	 * <p>
	 * The DrawDelegate class connects to a red5 server and handles calls to it. 
	 * 
	 */	
	public class DrawDelegate
	{
		public static const DEFAULT_RED5:String = "rtmp://localhost/test";
		
		private var conn:Connection;
        private var nc:NetConnection;
		
		private var boardModel:DrawModelLocator = DrawModelLocator.getInstance();
		private var dispatcher:CairngormEventDispatcher = boardModel.getDispatcher();
		private var draw:DrawModel = boardModel.draw;
		private var drawSO:SharedObject;
		private var uri:String;
		
		/**
		 *The default constructor of the DrawDelegate 
		 * 
		 */			
		public function DrawDelegate()
		{
			conn = new Connection();
			this.uri = DrawDelegate.DEFAULT_RED5;
			// add a listener for a successful connection...
            conn.addEventListener(Connection.SUCCESS, handleSucessfulConnection);
          
            // add a listener for no successful connection...
            conn.addEventListener(Connection.DISCONNECTED, handleDisconnection);
            
            conn.setURI(uri);
            conn.connect();
		}
		
		/**
		 * Handles a successful connection to the red5 server 
		 * @param e The connection event passed to the method
		 * 
		 */		
		public function handleSucessfulConnection(e:ConnectionEvent):void{
			nc = conn.getConnection();
			drawSO = SharedObject.getRemote("drawSO", uri, false);
            drawSO.addEventListener(SyncEvent.SYNC, sharedObjectSyncHandler);
            drawSO.client = this;
            drawSO.connect(nc);
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
			
		}
		
		/**
		 * Sends a shape to the Shared Object on the red5 server, and then triggers an update across all clients
		 * @param shape The shape sent to the SharedObject
		 * 
		 */		
		public function sendShape(shape:Array):void{
			drawSO.send("addSegment", shape);
		}
		
		/**
		 * Adds a shape to the ValueObject, then triggers an update event
		 * @param array The array representation of a shape
		 * 
		 */		
		public function addSegment(array:Array):void{
			draw.drawVO.segment = array;
			var cgEvent:UpdateEvent = new UpdateEvent();
			dispatcher.dispatchEvent(cgEvent);
		}

	}
}