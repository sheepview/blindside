
package org.blindsideproject.core.apps.presentation.services
{
	import flash.events.*;

	import mx.core.Application;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.blindsideproject.core.util.log.*;
	import org.blindsideproject.core.apps.presentation.model.*;

	import mx.rpc.IResponder;
	        	
	public class PresentationService
	{
		private var model : PresentationFacade = PresentationFacade.getInstance();  
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		    
		private var service : HTTPService;
		
		private var responder : IResponder;
		
		public function PresentationService(url:String, responder : IResponder)
		{
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