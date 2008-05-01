package org.blindsideproject.meetme.model
{
	import com.adobe.cairngorm.model.IModelLocator;
	import com.adobe.cairngorm.*;

	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import org.blindsideproject.meetme.business.NetConnectionDelegate;
		
	[Bindable]
	public class MeetMeModelLocator implements IModelLocator
	{
		private static var instance : MeetMeModelLocator;
		private var log : ILogger = LoggerModelLocator.getInstance().log;
		
		// Dispatcher to send events to UIs
		private var dispatcher : CairngormEventDispatcher = CairngormEventDispatcher.getInstance();
		
		public var meetMeRoom : MeetMeRoom;
		
		private var conn : NetConnectionDelegate;
				
		public function MeetMeModelLocator()
		{
	   		if ( instance != null )
					throw new CairngormError(
					   CairngormMessageCodes.SINGLETON_EXCEPTION, "MeetMeModelLocator" );
					
				initialize();			
		}
		
		public static function getInstance() : MeetMeModelLocator
		{
			if ( instance == null )
				instance = new MeetMeModelLocator();
				
			return instance;
	   	}		
		
	   	private function initialize() : void
	   	{		

	   	}	
	   	
	   	// Had to create this to prevent stack overflow when done during initialize	 
	   	public function setupMeetMeRoom() : void
	   	{
			meetMeRoom = new MeetMeRoom();
			conn = new NetConnectionDelegate(meetMeRoom);	   		
	   	}  	
	   	
	   	public function getMeetMeRoom() : MeetMeRoom
	   	{
	   		return meetMeRoom;
	   	}
	   		   	
	   	public function getDispatcher() : CairngormEventDispatcher
	   	{
	   		return dispatcher;
	   	}
	}
}