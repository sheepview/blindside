package org.blindsideproject.chat.command
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	import org.blindsideproject.chat.event.GetMessageEvent;
    import org.blindsideproject.chat.business.*;
    import org.blindsideproject.chat.model.*;
    import mx.rpc.IResponder;
	public class GetMessageCommand implements ICommand , IResponder
	{
		
		private var name:String;
		private var message:String;
		
		
		
		
	public function execute(cgEvent:CairngormEvent):void
		{
			
			var event : GetMessageEvent = GetMessageEvent( cgEvent );
			
			message = event.message;
			name = event.name;
			
//			delegate.getMessage(message,name);
        }
        
        
         public function result( event : Object ) : void
          {
               
               //var item:Object = event.message;
               //var chat:ChatVO = new ChatVO();

               //chat.message = item.message;
              
               
               //model.chat = chat;
              


          }

          //-------------------------------------------------------------------------

          public function fault( event : Object ) : void
          {
              // Alert.show(event.fault);
          }

          [Bindable]
          public var model : ChatModelLocator = ChatModelLocator.getInstance();
		
	}
}