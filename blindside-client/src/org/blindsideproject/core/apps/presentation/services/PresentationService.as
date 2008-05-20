
package org.blindsideproject.core.apps.presentation.services
{
	import flash.events.*;
	
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;
	
	import org.blindsideproject.core.apps.presentation.model.*;
	import org.blindsideproject.core.util.log.*;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	        	
	public class PresentationService extends Proxy implements IProxy
	{
		public static const ID:String = "PresentationService";
		
		private var model : PresentationFacade = PresentationFacade.getInstance();  
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		    
		private var service : HTTPService;
		
		private var responder : IResponder;
		
		public function PresentationService(url:String, responder : IResponder)
		{
			super(ID);
			service = new HTTPService();
			this.responder = responder;
			load(url);
		}
		
		public function load(url : String) : void
		{
			service.url = url;

			log.debug("getting slides from [" + service.url + "]");
			
			var call : Object = service.send();
			call.addResponder(responder);
			
		}
	}
}