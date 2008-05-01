package org.blindsideproject.conference.vo
{
	public class ParticipantVo
	{
		public var status : String;
		public var userId : Number;
		public var name : String;
		
		public function ParticipantVo() {
			status = "Sleeping";
			userId = 1;
			name = "Richard Alam";
		}
	}
}