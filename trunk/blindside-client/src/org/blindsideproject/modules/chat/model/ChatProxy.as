package org.blindsideproject.modules.chat.model
{
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class ChatProxy extends Proxy implements IProxy
	{
		public function ChatProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
		}
		
		public function getProxyName():String
		{
			return null;
		}
		
		public function setData(data:Object):void
		{
		}
		
		public function getData():Object
		{
			return null;
		}
		
		public function onRegister():void
		{
		}
		
		public function sendNotification(notificationName:String, body:Object=null, type:String=null):void
		{
		}
		
		public function onRemove():void
		{
		}
		
		public function initializeNotifier(key:String):void
		{
		}
		
	}
}