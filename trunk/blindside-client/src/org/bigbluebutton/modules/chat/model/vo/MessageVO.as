package org.bigbluebutton.modules.chat.model.vo
{	
	/**
	 * 
	 * Value object class
	 * The message itself and some attributes of it
	 * 
	 */	
	
	[Bindable]
	public class MessageVO
	{
		public var message:MessageObject;
		

		public var color : uint;
		public var font : String;
		public var fontSize : uint;
		public var bold : Boolean;
		public var italic : Boolean;
		
		/**
		 * Constructor 
		 * 
		 */		
		public function MessageVO()
		{
			message = new MessageObject("",0xffff);
		}

	}
}