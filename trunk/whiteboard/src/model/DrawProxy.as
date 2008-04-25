package model
{
	import flash.events.SyncEvent;
	import flash.net.NetConnection;
	import flash.net.SharedObject;
	
	import model.component.DrawObject;
	import model.component.DrawObjectFactory;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import red5.as3.net.Connection;
	import red5.as3.net.events.ConnectionEvent;
	
	public class DrawProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "Draw Proxy";
		public static const DEFAULT_RED5:String = "rtmp://localhost/test";
		
		private var conn:Connection;
		private var nc:NetConnection;
		private var drawSO:SharedObject;
		private var uri:String;
		
		private var drawFactory:DrawObjectFactory = new DrawObjectFactory();
		
		public function DrawProxy(drawVO:DrawVO)
		{
			super(NAME, drawVO);
			conn = new Connection;
			this.uri = DrawProxy.DEFAULT_RED5;
			conn.addEventListener(Connection.SUCCESS, handleSucessfulConnection);
			conn.addEventListener(Connection.DISCONNECTED, handleDisconnection);
			conn.setURI(this.uri);
			conn.connect();
		}
		
		public function get drawVO():DrawVO{
			return this.data as DrawVO;
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
		public function sendShape(shape:DrawObject):void{
			drawSO.send("addSegment", shape.getShapeArray(), shape.getType(), shape.getColor(), shape.getThickness());
		}
		
		/**
		 * Adds a shape to the ValueObject, then triggers an update event
		 * @param array The array representation of a shape
		 * 
		 */		
		public function addSegment(array:Array, type:String, color:uint, thickness:uint):void{
			var d:DrawObject = drawFactory.makeDrawObject(type,array,color,thickness);
			this.drawVO.segment = d;
			//var cgEvent:UpdateEvent = new UpdateEvent();
			//dispatcher.dispatchEvent(cgEvent);
		}

	}
}