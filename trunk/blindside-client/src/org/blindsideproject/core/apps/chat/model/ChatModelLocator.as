package org.blindsideproject.core.apps.chat.model
{
	import com.adobe.cairngorm.model.IModelLocator;
	import org.blindsideproject.core.apps.chat.vo.MessageVO;
	import mx.events.IndexChangedEvent;
	import com.adobe.cairngorm.*;
	import com.adobe.cairngorm.control.FrontController;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import org.blindsideproject.core.apps.chat.business.ChatDelegate;
	import org.blindsideproject.core.apps.chat.controller.ChatController;	
	

	public class ChatModelLocator implements IModelLocator
	{
		public static const ID : String = "org.blindsideproject.core.apps.chat.model.ChatModelLocator";

		private var _dispatcher : CairngormEventDispatcher = CairngormEventDispatcher.getInstance();
		private var _controller : FrontController = null;
		
		private static var modelLocator : ChatModelLocator;
		
		private var _chatDelegate : ChatDelegate = null;
		
		[Bindable]
		public var chat:ChatModel = new ChatModel();
		  	
	   	public function ChatModelLocator() 
	   	{
	   		if ( modelLocator != null )
					throw new CairngormError(
					   CairngormMessageCodes.SINGLETON_EXCEPTION, "ChatModelLocator" );
					   
		    initialize();		
	   	}
	   	
	   	public static function getInstance() : ChatModelLocator
		{
			if ( modelLocator == null )
				modelLocator = new ChatModelLocator();
				
			return modelLocator;
	   	}
	   	
	    private function initialize() : void
	   	{		
	   		_controller = new ChatController();
	   	}	
	  
	    public function get dispatcher() : CairngormEventDispatcher
	    	{
	   		return _dispatcher;
	   	}
	   	
	   	public function get chatDelegate() : ChatDelegate
	   	{
	   		if (_chatDelegate == null) {
	   			_chatDelegate = new ChatDelegate();
	   		}
	   		
	   		return _chatDelegate;
	   	}	
	}
}