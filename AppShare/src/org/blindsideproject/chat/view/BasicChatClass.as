
package org.blindsideproject.chat.view
{
	import mx.containers.Panel;
	
	import org.blindsideproject.chat.model.*;
	import org.blindsideproject.chat.vo.ChatVO;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import org.blindsideproject.chat.event.*;
	import org.blindsideproject.chat.command.*;
	import org.blindsideproject.chat.event.*;
	import mx.events.*;
	import flash.events.*;
	import mx.controls.TextArea;
	import mx.controls.TextInput;
	import mx.controls.Button;
	import mx.core.UIComponent;
    import mx.core.SpriteAsset;
    import mx.events.FlexEvent;
    import mx.effects.Resize;
    import mx.managers.CursorManager;
    import mx.core.Application;
    import flash.display.DisplayObject;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import superpanel.nl.wv.extenders.panel.*;
    
   
	
	public class BasicChatClass extends SuperPanel
	{		
		
		private var model : ChatModelLocator = ChatModelLocator.getInstance();
		public var txtChatBox : TextArea;
		
		[Bindable]		
		public var chatVO:ChatVO = model.chatVO;
		
		[Bindable]
		public var username : String = "Unknown";
				
		
		
		protected function connectToChatServer() : void
		{
			model.chat.setupConnection();
		}	
	
		public function sendMessage( msg : String) : void
		{					
			var cgEvent : SendMessageEvent = new SendMessageEvent(msg);
			cgEvent.dispatch();			
		}
				
		public function updateScroll () : void 
		{
			txtChatBox.verticalScrollPosition = txtChatBox.maxVerticalScrollPosition;
		}
		
	}
}