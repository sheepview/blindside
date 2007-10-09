package org.blindsideproject.WhiteBoard.business
{
	import mx.rpc.IResponder;
	import org.blindsideproject.WhiteBoard.model.DrawModelLocator;
	import org.blindsideproject.WhiteBoard.model.Draw;
	import flash.net.NetConnection;
	import flash.net.SharedObject;
	import flash.net.ObjectEncoding;
	import flash.events.NetStatusEvent;
	import flash.events.AsyncErrorEvent;
	import flash.events.SyncEvent;
	import flash.display.Shape;
	
	public class DrawDelegate implements IResponder
	{
		private var model:DrawModelLocator = DrawModelLocator.getInstance();
		private var responder:IResponder;
		private var service:Object;
		private var draw:Draw = model.draw;
		private var drawVO = model.drawVO;
		private var netConnection:NetConnection = draw.nc;
		private var soDraw: SharedObject;
		private var uri:String = "";
		
		public function DrawDelegate(uri:String){
			this.uri = uri;
			connect();
		}
		
		public function connect():void{
			draw.nc = new NetConnection();
			draw.nc.client = this;
			draw.nc.connect(uri);
			
			NetConnection.defaultObjectEncoding = flash.net.ObjectEncoding.AMF0;
			SharedObject.defaultObjectEncoding = flash.net.ObjectEncoding.AMF0;
			
			soDraw = SharedObject.getRemote("blindsideDraw", uri, true);
			soDraw.client = this;
			soDraw.connect(draw.nc);
		}
		
		public function close():void{
			if (soDraw != null)
				soDraw.close();
			
			netConnection.close();
		}
		
		public function sendShape(shape:Array):void{
			soDraw.send("newShape", shape);
		}
		
		public function newShape(shape:Array):void{
			model.drawVO.segment = shape;
			draw.updateEvent();
		}
		
		public function sendColor(color:uint):void{
			soDraw.send("newColor", color);
		}
		
		public function newColor(color:uint):void{
			model.drawVO.color = color;
		}
		
		public function sendClear(clear:Boolean):void{
			soDraw.send("clearAll", clear);
		}
		
		public function clearAll(clear:Boolean):void{
			model.drawVO.clear = clear;
			draw.clearEvent();
		}
		
		public function result(event:Object):void{
			
		}
		
		public function fault(event:Object):void{
			
		}
		
		public function setId( id:Number ):*
		{
			if( isNaN( id ) ) return;
			return "Okay";
		}	        
	}
}