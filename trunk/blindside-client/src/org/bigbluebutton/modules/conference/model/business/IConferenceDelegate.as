package org.bigbluebutton.modules.conference.model.business
{
	import org.bigbluebutton.modules.conference.model.vo.UserVO;
	
	public interface IConferenceDelegate
	{
   		function joinSuccess(user : UserVO) : void;
   		function joinFailed(reason : String) : void;   		   		
   		function connectSuccess() : void;
   		function connectFailed() : void;
   		function leftConference() : void;
 	}
}