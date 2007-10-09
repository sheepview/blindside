package org.blindsideproject.meetme.view
{
	import mx.containers.Box;
	import org.blindsideproject.meetme.model.MeetMeModelLocator;
	import org.blindsideproject.meetme.model.MeetMeRoom;
	import org.blindsideproject.meetme.business.NetConnectionDelegate;
	import org.blindsideproject.meetme.events.*;

	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
    import superpanel.nl.wv.extenders.panel.SuperPanel;
	import mx.controls.TileList;

	
	public class MeetMeUserListClass extends SuperPanel
	{
		private var model : MeetMeModelLocator = MeetMeModelLocator.getInstance();
		private var dispatcher : CairngormEventDispatcher = model.getDispatcher();
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		
		
		[Bindable]
		public var meetMeRoom : MeetMeRoom = model.meetMeRoom;;
		
		[Bindable] 
		public var participantsList:TileList; 
		
		[Bindable]
		public var userRole : uint;
/*		
		protected function connectToMeetMe() : void
	   	{
			model.meetMeRoom.getConnection().connect();
			meetMeRoom = model.meetMeRoom;
			meetMeRoom.userRole = userRole;
			
	   	}
*/
	}  	
}