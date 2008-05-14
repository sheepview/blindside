package org.red5.samples.publisher.control.handlers 
{	
	 
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.red5.samples.publisher.business.*;
	import org.red5.samples.publisher.model.*;
	
	public class CloseConnectionCommandHandler implements ICommand 
	{		
		private var modelLoc : PublisherModelLocator = PublisherModelLocator.getInstance();
			
	 	public function execute( cgEvent : CairngormEvent ) : void
	    { 
			modelLoc.netConnDelegate.close();
		}

	}
}