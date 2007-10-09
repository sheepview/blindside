package org.blindsideproject.core.apps.conference
{
	import org.blindsideproject.core.apps.conference.model.ConferenceModelLocator
	
	import org.blindsideproject.core.apps.conference.controller.commands.JoinCommand;
			
	import mx.utils.StringUtil;
	import org.blindsideproject.core.apps.conference.model.Conference;
	import org.blindsideproject.core.apps.conference.controller.commands.BroadcastStreamCommand;
		
	public class ConferenceApplication
	{
		private var model : ConferenceModelLocator = ConferenceModelLocator.getInstance();
		
		private var _host : String;
		
		[Bindable] public var conference : Conference = model.conference;
		
		public function ConferenceApplication(host : String) 
		{
			_host = host;
		}
		
		public function join(name : String, password : String, room : String) : void
		{
			// We need to build the host here because we need the room info
			var completeHost : String = "rtmp://" + _host + "/conference/" + room;
			
			//remove extra whitespaces in case use uses cut 'n paste
			var command : JoinCommand = new JoinCommand(StringUtil.trim(name), StringUtil.trim(password),
					StringUtil.trim(room), StringUtil.trim(completeHost));			
			command.dispatch();				
		}
		
		public function sendBroadcastStream(hasStream : Boolean, streamName : String) : void
		{
			var command : BroadcastStreamCommand = new BroadcastStreamCommand(hasStream, streamName);
			command.dispatch();
		}
	}
}