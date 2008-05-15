package org.blindsideproject.views.chat
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import flash.events.*;
	
	import flexlib.mdi.containers.MDIWindow;
	
	import mx.controls.ColorPicker;
	import mx.controls.TextArea;
	import mx.events.*;
	
	import org.blindsideproject.core.apps.chat.controller.commands.*;
	import org.blindsideproject.core.apps.chat.controller.handlers.*;
	import org.blindsideproject.core.apps.chat.model.*;
	import org.blindsideproject.core.apps.chat.vo.MessageVO;
	import org.blindsideproject.core.apps.conference.model.ConferenceModelLocator;
    
   	
	public class ChatWindowClass extends MDIWindow
	{		
		
		protected var model : ChatModelLocator = ChatModelLocator.getInstance();
		private var cmodel : ConferenceModelLocator = ConferenceModelLocator.getInstance();
		private var dispatcher : CairngormEventDispatcher = model.dispatcher;
		public var txtChatBox : TextArea;
		public var cmpColorPicker : ColorPicker;
		[Bindable]		
		public var messageVO:MessageVO = model.chat.messageVO;
//		[Bindable]		public var username : String = cmodel.conference.me.username;
				
		public function sendMessage(msg : String) : void
		{					
			var cgCommand : SendMessageCommand = new SendMessageCommand(msg);
			cgCommand.dispatch();			
		}
				
		public function updateScroll () : void 
		{
			txtChatBox.verticalScrollPosition = txtChatBox.maxVerticalScrollPosition;
		}
		
	}
}