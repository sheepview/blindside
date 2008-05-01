package org.blindsideproject.conference.view
{
	import mx.containers.Canvas;
	import org.blindsideproject.conference.model.Conference;


	public class ConferenceAppClass extends Canvas
	{
		[Bindable]
		public var conference : Conference;
	
		public function ConferenceAppClass() {
			
		}
		
		public function getConference() : Conference
		{
			return conference;
		}
	}
}