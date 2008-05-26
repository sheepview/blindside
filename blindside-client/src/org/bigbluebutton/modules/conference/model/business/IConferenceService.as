package org.bigbluebutton.modules.conference.model.business
{
	import org.bigbluebutton.modules.conference.model.vo.UserVO;
	
	public interface IConferenceService
	{
		function connect(host : String ) : void;
		function join(user : UserVO ) : void;	
		function leave() : void;
	}
}