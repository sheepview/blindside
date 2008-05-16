package org.blindsideproject.asterisk.meetme;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.asteriskjava.live.ManagerCommunicationException;
import org.asteriskjava.live.MeetMeUser;
import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IScope;
import org.red5.server.api.Red5;

public class MeetMeService extends ApplicationAdapter {
	protected static Logger logger = LoggerFactory.getLogger(MeetMeService.class);
	
	private ConferenceRoomListener roomListener;
	
	public Map<String, List> getMeetMeUsers() {
		// get the current scope that the current connection is associated with...
    	IScope scope = Red5.getConnectionLocal().getScope();	
    	
    	logger.debug("GetMeetmeUsers request for room[" + scope.getName() + "]");
    	
    	Map<String, List> usersMap = new HashMap<String, List>();;

	   	if (hasSharedObject(scope, "meetMeUsersSO")) {
	   		logger.info("MeetMe::service - Getting current users for room " + scope.getName());
    		
    		// Get the users in the room
    		Collection<MeetMeUser> currentUsers = roomListener.getCurrentUsers(scope.getName());
    		
    		logger.info("MeetMe::service - There are " + currentUsers.size() + " current users...");
    		
    		for (Iterator it = currentUsers.iterator(); it.hasNext();) {
    			MeetMeUser oneUser = (MeetMeUser) it.next();
    			
    			List <Object>aUser = new ArrayList<Object>();
    			aUser.add(oneUser.getUserNumber());
    			aUser.add(oneUser.getChannel().getCallerId().getName());
    			aUser.add(oneUser.getChannel().getCallerId().getNumber());
    			aUser.add(new Boolean(oneUser.isMuted()));
    			aUser.add(new Boolean(oneUser.isTalking()));   
    			
    			usersMap.put(oneUser.getUserNumber().toString(), aUser);

    		}  
    	} 
	   	
	   	logger.info("MeetMe::service - Sending " + usersMap.size() + " current users...");
	   	return usersMap;
	}
	
	public void muteAllUsers(Boolean mute) {
		// get the current scope that the current connection is associated with...
    	IScope scope = Red5.getConnectionLocal().getScope();	
    	
    	logger.debug("MuteUnmuteAll request for room[" + scope.getName() + "]");
	   	
    	if (hasSharedObject(scope, "meetMeUsersSO")) {
	   		logger.info("MeetMe::service - Getting current users for room " + scope.getName());
    		
    		// Get the users in the room
    		Collection<MeetMeUser> currentUsers = roomListener.getCurrentUsers(scope.getName());
    		
    		logger.info("MeetMe::service - There are " + currentUsers.size() + " current users...");
    		
    		for (Iterator it = currentUsers.iterator(); it.hasNext();) {
    			MeetMeUser oneUser = (MeetMeUser) it.next();
    			if (mute) {
    				if (! oneUser.isMuted()) {
    					try {
    						oneUser.mute();
    					} catch (ManagerCommunicationException e) {
    						// TODO Auto-generated catch block
    						e.printStackTrace();
    					}
    				}
    			} else {
    				if (oneUser.isMuted()) {
    					try {
    						oneUser.unmute();
    					} catch (ManagerCommunicationException e) {
    						// TODO Auto-generated catch block
    						e.printStackTrace();
    					}  
    				}
    			}
    		}  
    	} 
	}	
	
	public void muteUnmuteUser(Integer userId, Boolean muteUser) {
		// get the current scope that the current connection is associated with...
    	IScope scope = Red5.getConnectionLocal().getScope();
    	
    	logger.debug("MuteUnmute request for user [" + userId + "] in room[" + scope.getName() + "]");		
		
    	if (hasSharedObject(scope, "meetMeUsersSO")) {
			MeetMeUser theUser = roomListener.getUser(userId, scope.getName());
			
			if (theUser == null) {
				logger.warn("Cannot find user[" + userId + "] in room[" + scope.getName() + "]");
				return;
			}
			
			if (muteUser) {
				try {
					logger.debug("Muted user[" + userId + "] in room[" + scope.getName() + "]");
					theUser.mute();
				} catch (ManagerCommunicationException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} else {
				try {
					theUser.unmute();
					logger.debug("Unmuted user[" + userId + "] in room[" + scope.getName() + "]");
				} catch (ManagerCommunicationException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}

	public void ejectUser(Integer userId) {
		// get the current scope that the current connection is associated with...
    	IScope scope = Red5.getConnectionLocal().getScope();
    	
    	logger.debug("ejectUser " + userId + " request for room[" + scope.getName() + "]");		
		
    	if (hasSharedObject(scope, "meetMeUsersSO")) {
			MeetMeUser theUser = roomListener.getUser(userId, scope.getName());
			
			if (theUser == null) {
				logger.warn("Cannot find user[" + userId + "] in room[" + scope.getName() + "]");
				return;
			}
						
			try {
				theUser.kick();
				logger.debug("Kicked user[" + userId + "] in room[" + scope.getName() + "]");
			} catch (ManagerCommunicationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	}	
	
	public void setRoomListener(ConferenceRoomListener roomListener) {
		this.roomListener = roomListener;
	}	
}
