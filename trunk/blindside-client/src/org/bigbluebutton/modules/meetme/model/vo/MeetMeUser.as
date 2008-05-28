package org.bigbluebutton.modules.meetme.model.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	public class MeetMeUser implements IValueObject
	{
	[RemoteClass(alias="org.blindsideproject.asterisk.meetme.vo.MeetMeUserVo")]		
//		public static var registered:Boolean 
//			= ValueObject.registerClass("org.blindsideproject.asterisk.meetme.vo.MeetMeUserVo");
			
		public var roomNumber : String;
		public var callerIdName : String;
		public var callerIdNumber : String;
		public var dateJoined : Date;
		public var dateLeft : Date;
		public var userNumber : Number;
		public var muted : Boolean;
		public var talking : Boolean;	
		
			
	}
}