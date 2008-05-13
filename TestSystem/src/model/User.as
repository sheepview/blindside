package model
{
	[Bindable]
	public class User
	{
		public var userid : Number;
		public var name : String;
		public var message : String;
		//public var status : String = "lowerhand";
		//public var role : String = Role.VIEWER;	
		public function User(userid:Number , message:String)
		{
			this.userid = userid;
			this.message = message;
		}
		/**
		 * If the user is broadcasting a stream (video and/or audio)
		 */ 	
		//public var hasStream : Boolean = false;
		
		/**
		 * The name of the stream the user id broadcasting
		 */
		//public var streamName : String = null;
	}
}