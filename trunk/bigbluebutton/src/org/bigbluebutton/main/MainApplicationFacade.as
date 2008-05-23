package org.bigbluebutton.main
{
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.interfaces.INotification;

	public class MainApplicationFacade extends Facade implements IFacade
	{
		public function MainApplicationFacade(key:String)
		{
			//TODO: implement function
			super(key);
		}
		
		public function registerProxy(proxy:IProxy):void
		{
			//TODO: implement function
		}
		
		public function retrieveProxy(proxyName:String):IProxy
		{
			//TODO: implement function
			return null;
		}
		
		public function sendNotification(notificationName:String, body:Object=null, type:String=null):void
		{
			//TODO: implement function
		}
		
		public function removeProxy(proxyName:String):IProxy
		{
			//TODO: implement function
			return null;
		}
		
		public function initializeNotifier(key:String):void
		{
			//TODO: implement function
		}
		
		public function hasProxy(proxyName:String):Boolean
		{
			//TODO: implement function
			return false;
		}
		
		public function registerCommand(noteName:String, commandClassRef:Class):void
		{
			//TODO: implement function
		}
		
		public function removeCommand(notificationName:String):void
		{
			//TODO: implement function
		}
		
		public function hasCommand(notificationName:String):Boolean
		{
			//TODO: implement function
			return false;
		}
		
		public function registerMediator(mediator:IMediator):void
		{
			//TODO: implement function
		}
		
		public function retrieveMediator(mediatorName:String):IMediator
		{
			//TODO: implement function
			return null;
		}
		
		public function removeMediator(mediatorName:String):IMediator
		{
			//TODO: implement function
			return null;
		}
		
		public function hasMediator(mediatorName:String):Boolean
		{
			//TODO: implement function
			return false;
		}
		
		public function notifyObservers(notification:INotification):void
		{
			//TODO: implement function
		}
		
		public function removeCore(key:String):void
		{
			//TODO: implement function
		}
		
	}
}