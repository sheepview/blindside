package org.blindsideproject.core.apps.conference.business
{
	public interface IConferenceDelegate
	{
		function join(host : String, name : String, password : String, room : String) : void;
		
		function leave() : void;
		
		function sendNewStatus(newStatus : String) : void;
		
		function sendBroadcastStream(hasStream : Boolean, streamName : String) : void;
	}
}