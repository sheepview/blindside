package org.blindsideproject.chat.command
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.commands.ICommand;
	import org.blindsideproject.chat.event.SendMessageEvent;
    import org.blindsideproject.chat.business.*;

    import org.blindsideproject.chat.model.*;

	public class SendMessageCommand implements ICommand
	{
		
		private var name:String;
		private var message:String;
		
		public function execute(cgEvent:CairngormEvent):void
		{
			var event : SendMessageEvent = SendMessageEvent( cgEvent );
						
			message = event.message;			
			model.chat.chatDelegate.sendMessage(message);
			
		}
		
        [Bindable]
        public var model : ChatModelLocator = ChatModelLocator.getInstance();
	}
}