package org.blindsideproject.chat.model
{
	import com.adobe.cairngorm.model.IModelLocator;
	import org.blindsideproject.chat.vo.ChatVO;
	import mx.events.IndexChangedEvent;
	import com.adobe.cairngorm.*;

	public class ChatModelLocator implements IModelLocator
	{
		
		private static var modelLocator : ChatModelLocator;
		
		/**
	   	 * @throws CairngormError Only one ModelLocator instance should be instantiated.
	   	 */	   	
	   	public function ChatModelLocator() 
	   	{
	   		if ( modelLocator != null )
					throw new CairngormError(
					   CairngormMessageCodes.SINGLETON_EXCEPTION, "ChatModelLocator" );
					   	
			chatVO = new ChatVO();
			chat = new Chat();			
	   	}
	   	
	   	
		/**
		 * 
		 * @return ModelLocator
		 */		
		public static function getInstance() : ChatModelLocator
		{
			if ( modelLocator == null )
				modelLocator = new ChatModelLocator();
				
			return modelLocator;
	   	}
	   	
	   	/**
	   	 * 
	   	 */	   	
	   	public var chatVO:ChatVO;
	   	public var chat:Chat;
	   	
	}
}