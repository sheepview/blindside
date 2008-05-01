package org.blindsideproject.views.chat
{
	import mx.containers.Panel;
	import org.blindsideproject.core.apps.chat.model.*;
	import org.blindsideproject.core.apps.chat.vo.MessageVO;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import org.blindsideproject.core.apps.chat.controller.handlers.*;
	import org.blindsideproject.core.apps.chat.controller.commands.*;
	import mx.events.*;
	import flash.events.*;
	import mx.controls.TextArea;
	import mx.controls.TextInput;
	import mx.controls.Button;
	import mx.core.UIComponent;
    import mx.events.FlexEvent;
    import mx.core.Application;
    import superpanel.nl.wv.extenders.panel.*;
    import com.adobe.cairngorm.control.CairngormEvent;
    import org.blindsideproject.core.apps.conference.model.ConferenceModelLocator;
    import mx.controls.ColorPicker;
    
   	
	public class ChatClass extends SuperPanel
	{		
		
		protected var model : ChatModelLocator = ChatModelLocator.getInstance();
		private var cmodel : ConferenceModelLocator = ConferenceModelLocator.getInstance();
		private var dispatcher : CairngormEventDispatcher = model.dispatcher;
		public var txtChatBox : TextArea;
		public var cmpColorPicker : ColorPicker;
		[Bindable]		
		public var messageVO:MessageVO = model.chat.messageVO;
		[Bindable]
		public var username : String = cmodel.conference.me.username;
				
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