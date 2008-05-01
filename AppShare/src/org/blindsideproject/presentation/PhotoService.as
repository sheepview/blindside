////////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2003-2006 Adobe Macromedia Software LLC and its licensors.
// All Rights Reserved.
// The following is Sample Code and is subject to all restrictions on such code
// as contained in the End User License Agreement accompanying this product.
// If you have received this file from a source other than Adobe,
// then your use, modification, or distribution of it requires
// the prior written permission of Adobe.
//
////////////////////////////////////////////////////////////////////////////////
package org.blindsideproject.presentation
{
	import flash.events.*;

	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.core.Application;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.ArrayUtil;

	import org.blindsideproject.util.components.logger.model.*;
	import org.blindsideproject.presentation.model.*;
	        	
	public class PhotoService
	{
		private var model : PresentationModelLocator = PresentationModelLocator.getInstance();  
		private var log : Logger = model.getLogger();
		    
		private var service:HTTPService;

        [Bindable]
		public var galleries:ArrayCollection;

		public function PhotoService(url:String)
		{
			service = new HTTPService();
			service.url = url;
		//	service.resultFormat = "xml";
			
			log.debug("getting slides from [" + service.url + "]");
			
			service.addEventListener(ResultEvent.RESULT, resultHandler);
			service.send();
		//	service.send({room : '85115'});
		}

		private function resultHandler(event:ResultEvent):void
		{
			log.debug("Got result [" + event.result.toString() + "]");
		
			if (event.result.galleries == null)	return;
			
		    var result:ArrayCollection = event.result.galleries.gallery is ArrayCollection
		        ? event.result.galleries.gallery as ArrayCollection
		        : new ArrayCollection(ArrayUtil.toArray(event.result.galleries.gallery));
		    var temp:ArrayCollection = new ArrayCollection();
		    var cursor:IViewCursor = result.createCursor();
		    while (!cursor.afterLast)
		    {
		    	var gallery : Gallery = new Gallery(cursor.current);
		    	log.debug("Got gallery [" + gallery.description + "]");
		        temp.addItem(gallery);
		        
		        cursor.moveNext();
		    }
		    galleries = temp;
		}
	}
}