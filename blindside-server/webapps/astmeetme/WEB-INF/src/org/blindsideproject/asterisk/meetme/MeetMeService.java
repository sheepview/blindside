package org.blindsideproject.asterisk.meetme;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.asteriskjava.live.ManagerCommunicationException;
import org.asteriskjava.live.MeetMeUser;
import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IScope;
import org.red5.server.api.Red5;

public class MeetMeService extends ApplicationAdapter {
	private ConferenceRoomListener roomListener;
	
	public Map<String, List> getMeetMeUsers() {
		// get the current scope that the current connection is associated with...
    	IScope scope = Red5.getConnectionLocal().getScope();	
    	
    	Map<String, List> usersMap = new HashMap<String, List>();;

	   	if (hasSharedObject(scope, "meetMeUsersSO")) {
    		log.info("MeetMe::service - Getting current users for room " + scope.getName());
    		
    		// Get the users in the room
    		Collection<MeetMeUser> currentUsers = roomListener.getCurrentUsers(scope.getName());
    		
    		log.info("MeetMe::service - There are " + currentUsers.size() + " current users...");
    		
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
	   	
	   	log.info("MeetMe::service - Sending " + usersMap.size() + " current users...");
	   	return usersMap;
	}
	
	public void muteAllUsers(Boolean mute) {
		// get the current scope that the current connection is associated with...
    	IScope scope = Red5.getConnectionLocal().getScope();	
    	
	   	if (hasSharedObject(scope, "meetMeUsersSO")) {
    		log.info("MeetMe::service - Getting current users for room " + scope.getName());
    		
    		// Get the users in the room
    		Collection<MeetMeUser> currentUsers = roomListener.getCurrentUsers(scope.getName());
    		
    		log.info("MeetMe::service - There are " + currentUsers.size() + " current users...");
    		
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
    			
		if (hasSharedObject(scope, "meetMeUsersSO")) {
			MeetMeUser theUser = roomListener.getUser(userId, scope.getName());
			
			if (theUser == null) {
				log.warn("Cannot find user[" + userId + "] in room[" + scope.getName() + "]");
				return;
			}
			
			if (muteUser) {
				try {
					log.debug("Muted user[" + userId + "] in room[" + scope.getName() + "]");
					theUser.mute();
				} catch (ManagerCommunicationException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} else {
				try {
					theUser.unmute();
					log.debug("Unmuted user[" + userId + "] in room[" + scope.getName() + "]");
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
    			
		if (hasSharedObject(scope, "meetMeUsersSO")) {
			MeetMeUser theUser = roomListener.getUser(userId, scope.getName());
			
			if (theUser == null) {
				log.warn("Cannot find user[" + userId + "] in room[" + scope.getName() + "]");
				return;
			}
						
			try {
				theUser.kick();
				log.debug("Kicked user[" + userId + "] in room[" + scope.getName() + "]");
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
