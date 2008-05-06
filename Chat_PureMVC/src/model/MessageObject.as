package model
{
	public class MessageObject
	{
		public var color:uint;
		public var message:String;
		public function MessageObject(message:String , color:uint)
		{
			this.color = color;
			this.message = message;
		}
		
		public function getColor():uint{
			return this.color;
		}
		
		public function getMessgae (): String {
			return this.message;
		}

	}
}