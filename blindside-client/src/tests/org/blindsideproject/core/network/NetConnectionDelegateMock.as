package tests.org.blindsideproject.core.network
{

	import mx.rpc.events.FaultEvent;
	import mx.rpc.IResponder;
	import flash.events.Event;
	import mx.rpc.events.ResultEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.AsyncErrorEvent;

	public class NetConnectionDelegateMock
	{	
		private var responder : IResponder;
		//using a timer to simulate the latency during the client-server roundtrip
		private var timer:Timer;
		//the latency value can be set by the specific Business Delegates
		private var latency:Number = 0;  //the default value is no latency
		//holding the results in a global is a little awkward...
		private var results:Object;		
	
		public function NetConnectionDelegateMock( res : IResponder )
		{
			responder = res;
		}
		
		public function connect( uri : String, proxy : String, encoding : uint ) : void
		{
			
		}
			
		public function close() : void
		{

		}
			
		protected function netStatus( event : NetStatusEvent ) : void 
		{
			this.responder.result( event );
		}
		
		protected function netSecurityError( event : SecurityErrorEvent ) : void 
		{
		    responder.fault( new SecurityErrorEvent ( SecurityErrorEvent.SECURITY_ERROR, false, true,
		    										  "Security error - " + event.text ) );
		}
		
		protected function netIOError( event : IOErrorEvent ) : void 
		{
			responder.fault( new IOErrorEvent ( IOErrorEvent.IO_ERROR, false, true, 
							 "Input/output error - " + event.text ) );
		}
		
		protected function netASyncError( event : AsyncErrorEvent ) : void 
		{
			responder.fault( new AsyncErrorEvent ( AsyncErrorEvent.ASYNC_ERROR, false, true,
							 "Asynchronous code error - <i>" + event.error + "</i>" ) );
		}
    }
}