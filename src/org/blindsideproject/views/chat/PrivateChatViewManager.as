package org.blindsideproject.views.chat
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;

	import flash.events.Event;
	import org.blindsideproject.views.chat.PrivateChatPanel;
	import org.blindsideproject.core.apps.chat.controller.events.*;
	import mx.core.UIComponent;
	import org.blindsideproject.core.apps.chat.model.*;
	import org.blindsideproject.core.util.log.ILogger;
	
	public class PrivateChatViewManager
	{
		public var privateChatPanelArray : Array = new Array();
		private var model : ChatModelLocator = ChatModelLocator.getInstance();
		private var dispatcher : CairngormEventDispatcher = model.dispatcher;
		private var userid : Number;
		private var chatWindow : PrivateChatPanel;
	
		private var log : ILogger = model.log;
		
		public function init():void
		{
			dispatcher.addEventListener(ChatEvents.NEW_CHAT_MESSAGE_EVENT , onNewChatMessageEvent);
			//dispatcher.addEventListener(ChatEvents.OPEN_CHAT_WINDOW_EVENT , onOpenChatWindowEvent);
			//dispatcher.addEventListener(ChatEvents.NEW_CHAT_REQUEST_EVENT , onNewChatRequestEvent);
		}
		
		public function onNewChatMessageEvent(userid):void
		{
			this.userid = userid;
			//if(true) {}
			//if the window is open add effect and message 
			//else 
			//{
				//var chatRequest : NewChatRequestEvent = new NewChatRequestEvent(
			   // ChatEvents.NEW_CHAT_REQUEST_EVENT , userid);
			   // dispatcher.dispatchEvent(chatRequest);
		   // }
		}
		
	}
}