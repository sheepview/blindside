package org.blindsideproject.core.apps.conference.vo
{
	[Bindable]
	public class User
	{
		public var userid : Number;
		public var username : String;
		public var status : String = "lowerhand";
		public var role : uint = Role.PARTICIPANT;		
	}
}