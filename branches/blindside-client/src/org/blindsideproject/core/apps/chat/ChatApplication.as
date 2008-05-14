package org.blindsideproject.core.apps.chat
{
	import org.blindsideproject.core.apps.chat.model.ChatModel;
	import org.blindsideproject.core.apps.chat.model.ChatModelLocator;

	import org.blindsideproject.core.apps.chat.controller.commands.JoinCommand;
	import org.blindsideproject.core.apps.chat.controller.commands.LeaveCommand;
				
	public class ChatApplication
	{
		private var _url : String;
		private var _userid : Number;
		private var _room : String;
		
		public var model : ChatModel;
		
		public function ChatApplication(userid : Number, room : String, 
				url : String) : void
		{
			_url = url;
			_userid = userid;
			_room = room;			

			// Initialize the model
			model = ChatModelLocator.getInstance().chat;
		}
		
		public function join() : void
		{
			var join : JoinCommand = new JoinCommand(_url, _room);
			join.dispatch();
		}
		
		public function leave() : void
		{
			var leave : LeaveCommand = new LeaveCommand();
			leave.dispatch();
		}
	}
}