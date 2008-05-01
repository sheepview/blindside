package org.blindsideproject.WhiteBoard.model
{
	import flash.net.NetConnection;
	import org.blindsideproject.WhiteBoard.business.DrawDelegate;
	import org.blindsideproject.WhiteBoard.event.UpdateEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import org.blindsideproject.WhiteBoard.event.ClearEvent;
	
	public class Draw
	{
		public var nc:NetConnection;
		public var drawDelegate:DrawDelegate;
		public var uri:String = "rtmp://localhost/SOSample";
		public var dispatcher:CairngormEventDispatcher = CairngormEventDispatcher.getInstance();
		
		public function Draw(){}
		
		public function setupConnection():void{
			drawDelegate = new DrawDelegate(uri);
		}
		
		public function updateEvent():void{
			var event:UpdateEvent = new UpdateEvent();
			dispatcher.dispatchEvent(event);
		}
		
		public function clearEvent():void{
			var event:ClearEvent = new ClearEvent();
			dispatcher.dispatchEvent(event);
		}
	}
}