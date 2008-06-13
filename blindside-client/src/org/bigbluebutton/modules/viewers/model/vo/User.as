package org.bigbluebutton.modules.viewers.model.vo
{
	import org.bigbluebutton.common.Role;
	
	[Bindable]
	public class User
	{
		public var userid : Number;
		public var name : String;
		public var status : String = "lowerhand";
		public var role : String = Role.VIEWER;	
		
		/**
		 * If the user is broadcasting a stream (video and/or audio)
		 */ 	
		public var hasStream : Boolean = false;
		
		/**
		 * The name of the stream the user id broadcasting
		 */
		public var streamName : String = null;
	}
}