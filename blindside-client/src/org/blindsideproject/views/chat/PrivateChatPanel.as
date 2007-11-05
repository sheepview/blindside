package org.blindsideproject.views.chat
{
	import superpanel.nl.wv.extenders.panel.SuperPanel;
	import org.blindsideproject.core.apps.chat.controller.commands.PrivateMessageCommand;
	import mx.controls.TextArea;
	import mx.controls.Button;
	import mx.controls.ColorPicker;
	import mx.controls.TextInput;
	import mx.containers.HBox;
	import mx.core.UIComponent;
	import org.blindsideproject.core.apps.conference.model.*;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import mx.events.FlexEvent;
	import org.blindsideproject.core.apps.chat.model.ChatModelLocator;
	import org.blindsideproject.core.apps.chat.vo.PrivateMessageVO;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import org.blindsideproject.core.apps.chat.controller.events.*;
    import mx.binding.utils.*;
    import mx.controls.Spacer;
    import mx.containers.VBox;

	public class PrivateChatPanel extends SuperPanel
	{
		
		public var fromUserid : Number;
		public var toUserid : Number;
		public var fromUsername : String;
		public var toUsername : String;
		public var initiator : Boolean;
		[Bindable]
		public var message : String = "";
		public var formatMsg : String;
		//private var showCloseButton:Boolean = true;
		public var txtBox : TextArea = new TextArea();
		private var spacer : Spacer = new Spacer();
		private var hbox : HBox = new HBox();
        private var hbox2 : HBox = new HBox();
        private var sendButton : Button = new Button();
		
		private var txtInput : TextInput = new TextInput();
		private var cmpColorPicker : ColorPicker = new ColorPicker();
		
		private var model : ConferenceModelLocator = ConferenceModelLocator.getInstance();
		private var modelc : ChatModelLocator = ChatModelLocator.getInstance();
		private var dispatcher : CairngormEventDispatcher = modelc.dispatcher;
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		private var tempid : Number;
		
		public function PrivateChatPanel(userid : Number , toUserid : Number ,
		 fromUsername : String, toUsername : String , initiator : Boolean = false)
		{
	            super.showCloseButton = true;
	            fromUserid = userid;
	            this.toUserid = toUserid;
	            this.fromUsername = fromUsername;
	            this.toUsername = toUsername;
	            this.initiator = initiator;
	            this.showControls = true;
                this.enableResize = true;
                this.x = 100;
                this.y = 100;
                this.width = 280;
                this.height = 200;
                this.horizontalScrollPolicy = "off";
                this.verticalScrollPolicy = "off"
                this.layout = "vertical";
                this.title = "Private Chat with "+ toUsername;
                txtBox.width = this.width * (95/100);
                txtBox.height = this.height * (60/100);
                txtBox.editable = false;
                spacer.width = 3;
                this.addChild(txtBox);
                this.addChild(hbox);
                hbox.addChild(spacer);
                hbox.addChild(txtInput);
                hbox.addChild(cmpColorPicker);
                sendButton.label = "Send";
                sendButton.width =40;
                hbox.addChild(sendButton);
                sendButton.addEventListener(MouseEvent.CLICK , sendMessage);
                txtInput.addEventListener(FlexEvent.ENTER , sendMessage);
                
                init();
		}
		
		public function init():void
		{
			dispatcher.addEventListener(ChatEvents.NEW_CHAT_REQUEST_EVENT , onNewChatRequestEvent);
			BindingUtils.bindProperty(txtBox, "text", PrivateChatPanel , message); 
		}
		
		public function onNewChatRequestEvent(event : Event):void
		{
			var chatRequest : NewChatRequestEvent = NewChatRequestEvent (event);
			
			if (chatRequest.fromUserid == tempid)
			{
			     message +=  chatRequest.message + "\n";
			     txtBox.htmlText = message;
			}
		}
		
		public function sendMessage(event : Event):void
   		{
   			var msg : String = txtInput.text;
   		    formatMsg = "<font color=\"#" + 
						cmpColorPicker.selectedColor.toString(16) + "\"><b>[" + 
						model.conference.me.name + "]</b> " + msg + "</font>";
   		   			
   			dispatchMessage(formatMsg , fromUserid , toUserid , fromUsername , toUsername , initiator);
   			tempid = toUserid;
   			message += formatMsg + "\n";
   			txtBox.htmlText = message;
   			txtInput.text = "";
   		    txtBox.verticalScrollPosition = txtBox.maxVerticalScrollPosition;
   		}
   		
   		public function dispatchMessage(msg:String, fromUserid:Number , toUserid:Number ,
   		 fromUsername:String , toUsername:String , initiator:Boolean):void
   		{
   			var cgCommand : PrivateMessageCommand = new PrivateMessageCommand(msg ,
   			fromUserid , toUserid , fromUsername , toUsername , initiator);
			cgCommand.dispatch();
		}
		override public function closeClickHandler(event:MouseEvent):void
		{
			super.closeClickHandler(event);

			var closeChat : CloseChatWindowEvent = new CloseChatWindowEvent
			    (ChatEvents.CLOSE_CHAT_WINDOW_EVENT , fromUserid , toUserid , 
			    fromUsername , toUsername);
			    dispatcher.dispatchEvent(closeChat);
		}
		
	}
}