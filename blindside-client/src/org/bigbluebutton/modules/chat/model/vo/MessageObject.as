package org.bigbluebutton.modules.chat.model.vo
{
	public class MessageObject
	{
		public var color:uint;
		public var message:String;
		/**
		 * 
		 * @param message
		 * @param color
		 * 
		 */
		public function MessageObject(message:String , color:uint)
		{
			this.color = color;
			this.message = message;
		}
		/**
		 * 
		 * @return the color of message font
		 * 
		 */		
		public function getColor():uint{
			return this.color;
		}
		/**
		 * 
		 * @return a string containing the last message
		 * 
		 */		
		public function getMessage (): String {
			return this.message;
		}

	}
}