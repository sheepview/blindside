package org.blindsideproject.core.apps.chat.model
{
	import org.blindsideproject.core.IApplication;
	import org.blindsideproject.core.apps.chat.vo.MessageVO;
    import mx.collections.ArrayCollection;
    import org.blindsideproject.core.apps.chat.vo.PrivateMessageVO;
    import org.blindsideproject.views.chat.PrivateChatViewManager;
    import org.blindsideproject.views.chat.PrivateChatPanel;
	
	
	public class ChatModel implements IApplication
	{
		private var _connected : Boolean = false;
		private var _host : String;
		//private var _userid : int;
		//public var userid : Number;
		//public var toUserid : Number;
		public var messageVO : MessageVO;
		//public var index : Number = 0;
		//public var privateMessageVO : PrivateMessageVO;
		//public var privateChats : Array;
		//public var manager : PrivateChatViewManager;
		//public var chatPanels : Array;
		//public var privateChatPanel : PrivateChatPanel;
		public function ChatModel()
		{
			messageVO = new MessageVO("");
			//privateMessageVO = new PrivateMessageVO("");
			//privateChats = new Array();
			//manager = new PrivateChatViewManager();
			//chatPanels = new Array();
			//privateChatPanel = new PrivateChatPanel(userid,toUserid);
		}
		
		public function set connected(isConnected : Boolean) : void
		{
			_connected = isConnected;
		}
		
		public function get connected() : Boolean
		{
			return _connected;
		}
					
		public function set host(value : String) : void
		{
			_host = value;
		}
		
		public function get host() : String
		{
			return _host;
		}
		
		public function open(userId:Number):void
		{
		}
		
		public function getApplicationId():String
		{
			return null;
		}
		
		public function close():void
		{
		}
		
	}
}