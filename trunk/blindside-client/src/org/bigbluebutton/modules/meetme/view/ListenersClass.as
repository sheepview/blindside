package org.bigbluebutton.modules.meetme.view
{
	import flexlib.mdi.containers.MDIWindow;
	
	import mx.controls.TileList;
	
	import org.bigbluebutton.modules.meetme.MeetMeFacade;
	import org.bigbluebutton.modules.meetme.model.MeetMeRoom;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;

	
	public class ListenersClass extends MDIWindow
	{
		private var model:MeetMeFacade = MeetMeFacade.getInstance();
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		
		
		[Bindable]
		public var meetMeRoom:MeetMeRoom = model.meetMeRoom;;
		
		[Bindable] 
		public var participantsList:TileList; 
		
		[Bindable]
		public var userRole : uint;

	}  	
}