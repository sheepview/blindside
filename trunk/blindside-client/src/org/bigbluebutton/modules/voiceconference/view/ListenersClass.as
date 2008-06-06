package org.bigbluebutton.modules.voiceconference.view
{
	import flexlib.mdi.containers.MDIWindow;
	
	import mx.controls.TileList;
	
	import org.bigbluebutton.modules.voiceconference.VoiceConferenceFacade;
	import org.bigbluebutton.modules.voiceconference.model.VoiceConferenceRoom;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerFacade;

	/**
	 * This is a convinience class extended by the Listeners Window. It holds some variables
	 * @author Richard Alam
	 * 
	 */	
	public class ListenersClass extends MDIWindow
	{
		private var model:VoiceConferenceFacade = VoiceConferenceFacade.getInstance();
		
		[Bindable]
		public var meetMeRoom:VoiceConferenceRoom = model.meetMeRoom;;
		
		[Bindable] 
		public var participantsList:TileList; 
		
		[Bindable]
		public var userRole : uint;

	}  	
}