package org.blindsideproject.core.apps.presentation.controller.handlers
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	
	import org.blindsideproject.core.apps.presentation.model.PresentationFacade;
	import org.blindsideproject.core.apps.presentation.controller.commands.LoadCommand;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
	import org.blindsideproject.core.apps.presentation.vo.SlidesDeck;
	import org.blindsideproject.core.apps.presentation.services.PresentationService;
					
	import mx.rpc.IResponder;
	import mx.utils.ArrayUtil;
	import mx.collections.ArrayCollection;		
	import mx.collections.IViewCursor;
		
	public class LoadCommandHandler implements ICommand, IResponder
	{		
		private var model : PresentationFacade = PresentationFacade.getInstance();
		private var log : ILogger = LoggerModelLocator.getInstance().log;
			
		private var service : PresentationService;
					
		public function execute(cgCommand:CairngormEvent):void
		{
			var command : LoadCommand = LoadCommand(cgCommand);
	
			model.presentation.presentationLoaded = false;
			
			log.debug("In load command handler");
			service = new PresentationService(command.url, this);			
		}
		
		public function result(event : Object):void
		{
			log.debug("Got result [" + event.result.toString() + "]");
			
			if (event.result.presentations == null)	return;
			
		    var result:ArrayCollection = event.result.presentations.presentation is ArrayCollection
		        ? event.result.presentations.presentation as ArrayCollection
		        : new ArrayCollection(ArrayUtil.toArray(event.result.presentations.presentation));
		    
		    var temp:ArrayCollection = new ArrayCollection();
		    var cursor:IViewCursor = result.createCursor();
		    
		    while (!cursor.afterLast)
		    {
		    	var deck : SlidesDeck = new SlidesDeck(cursor.current);
		    	log.debug("Got gallery [" + deck.title + "]");
				model.presentation.newDeckOfSlides(deck);
		        cursor.moveNext();
		    }
		}

		public function fault(event : Object):void
		{
			log.debug("Got fault [" + event.fault.toString() + "]");		
		}		
	}
}