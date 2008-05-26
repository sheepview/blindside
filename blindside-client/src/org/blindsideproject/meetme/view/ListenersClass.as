package org.blindsideproject.meetme.view
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import flexlib.mdi.containers.MDIWindow;
	
	import mx.controls.TileList;
	
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
	import org.blindsideproject.meetme.model.MeetMeModelLocator;
	import org.blindsideproject.meetme.model.MeetMeRoom;

	
	public class ListenersClass extends MDIWindow
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

	}  	
}