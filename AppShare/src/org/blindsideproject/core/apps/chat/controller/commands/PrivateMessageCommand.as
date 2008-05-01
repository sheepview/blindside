package org.blindsideproject.core.apps.chat.controller.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.chat.controller.ChatController;
	
	public class PrivateMessageCommand extends CairngormEvent
	{
		private var _privateMessage : String;
		private var _fromUserid : Number;
		private var _toUserid : Number;
		private var _toUsername : String;
		private var _fromUsername : String;
		private var _initiator : Boolean;
		
		public function PrivateMessageCommand(privateMessage : String , fromUserid : Number ,
		 toUserid : Number , fromUsername : String , toUsername : String , initiator : Boolean) : void
		{
			super(ChatController.PRIVATE_MESSAGE_COMMAND);
			_privateMessage = privateMessage;
			_fromUserid = fromUserid;
			_toUserid = toUserid;
			_fromUsername = fromUsername;
			_toUsername = toUsername;
			_initiator = initiator;
			
		}		
		
		public function get privateMessage() : String
		{
			return _privateMessage;
		}
		public function get fromUserid() : Number
		{
			return _fromUserid;
		}
		public function get toUserid() : Number
		{
			return _toUserid;
		}
		public function get initiator() : Boolean
		{
			return _initiator;
		}
		public function get toUsername() : String
		{
			return _toUsername;
		}
		public function get fromUsername() : String
		{
			return _fromUsername;
		}
		
	}
}