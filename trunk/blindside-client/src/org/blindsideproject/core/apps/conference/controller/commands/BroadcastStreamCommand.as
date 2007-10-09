package org.blindsideproject.core.apps.conference.controller.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.blindsideproject.core.apps.conference.controller.ConferenceController;

	public class BroadcastStreamCommand extends CairngormEvent
	{
		private var _hasStream : Boolean = false;
		private var _streamName : String;
		
		public function BroadcastStreamCommand(hasStream : Boolean, streamName : String = null) : void {
			super(ConferenceController.BROADCAST_STREAM_COMMAND);
			_hasStream = hasStream;
			_streamName = streamName;
		}
		
		public function get hasStream() : Boolean
		{
			return _hasStream;
		}
		
		public function get streamName() : String
		{
			return _streamName;
		}
	}
}