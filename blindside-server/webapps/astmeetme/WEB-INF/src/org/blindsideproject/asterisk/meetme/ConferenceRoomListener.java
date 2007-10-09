package org.blindsideproject.asterisk.meetme;

import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.asteriskjava.live.AbstractAsteriskServerListener;
import org.asteriskjava.live.MeetMeUser;
import org.asteriskjava.live.MeetMeUserState;
import org.blindsideproject.asterisk.AsteriskVoiceService;
import org.red5.server.api.so.ISharedObject;

public class ConferenceRoomListener extends AbstractAsteriskServerListener {
	
	private final Log log = LogFactory.getLog(getClass());
	private AsteriskVoiceService voiceService;

	
	private static Map<String, ISharedObject> meetMeSOs = new HashMap<String, ISharedObject>();
	
	public ConferenceRoomListener() {
		log.debug("RoomListener started...");
	}

    public void onNewMeetMeUser(MeetMeUser user)
    {
		log.info("New user joined meetme room: " + user.getRoom() + 
				" " + user.getChannel().getCallerId().getName());
		
		String roomNumber = user.getRoom().getRoomNumber();
		
		if (meetMeSOs.containsKey(roomNumber)) {
			ISharedObject so = meetMeSOs.get(roomNumber);
			user.addPropertyChangeListener(new ParticipantPropertyChangeListener(so));

			List <Object>args = new ArrayList<Object>();
			args.add(user.getUserNumber());
			args.add(user.getChannel().getCallerId().getName());
			args.add(user.getChannel().getCallerId().getNumber());
			args.add(new Boolean(user.isMuted()));
			args.add(new Boolean(user.isTalking()));
			
			so.sendMessage("userJoin", args);
		}
    }
    
    public void addRoom(String room, ISharedObject so) {
    	meetMeSOs.put(room, so);
    	
    	getCurrentUsers(room);
    }
    
    public MeetMeUser getUser(Integer userId, String room) {
    	if (meetMeSOs.containsKey(room)) {
    		// Get the users in the room
    		Collection<MeetMeUser> currentUsers = voiceService.getUsers(room);

    		log.info("MeetMe::roomListener - There are [" + currentUsers.size() 
    				+ "] in room = [" + room + "]");    		
    		
    		for (Iterator it = currentUsers.iterator(); it.hasNext();) {
    			MeetMeUser oneUser = (MeetMeUser) it.next();
    			
    			log.info("MeetMe::roomListener - Looking at userid = [" + oneUser.getUserNumber() 
	    				+ "] in room = [" + oneUser.getRoom().getRoomNumber() + "]");
    			
    			if (oneUser.getUserNumber().intValue() == userId.intValue()) {
    	    		log.info("MeetMe::roomListener - Found userid = [" + userId 
    	    				+ "] in room = [" + room + "]");
    				return oneUser;
    			}
    		}    
    	}
    	
    	return null;    	
    }
    
    public Collection<MeetMeUser> getCurrentUsers(String room) {
    	if (meetMeSOs.containsKey(room)) {
    		ISharedObject so = (ISharedObject) meetMeSOs.get(room);
    	
    		// Get the users in the room
    		Collection<MeetMeUser> currentUsers = voiceService.getUsers(room);
		
    		log.info("MeetMe::roomListener - There are " + currentUsers.size() 
    				+ " current users in room [" + room + "]");
		
    		for (Iterator it = currentUsers.iterator(); it.hasNext();) {
    			MeetMeUser oneUser = (MeetMeUser) it.next();
    			oneUser.addPropertyChangeListener(new ParticipantPropertyChangeListener(so));
    		}    
    		
    		return currentUsers;
    	}
    	
    	return null;
    }
    
    public static ISharedObject getSharedObject(String room) {
    	if (meetMeSOs.containsKey(room)) {
    		return (ISharedObject) meetMeSOs.get(room);
    	}
    	
    	return null;
    }
    
	private class ParticipantPropertyChangeListener implements PropertyChangeListener {
		private ISharedObject so;
		
		public ParticipantPropertyChangeListener(ISharedObject so) {
			this.so = so;
		}
		
		public void propertyChange(PropertyChangeEvent evt) {
			MeetMeUser changedUser = (MeetMeUser) evt.getSource();
		
			log.info("Received property changed event for " + evt.getPropertyName() +
					" old = '" + evt.getOldValue() + "' new = '" + evt.getNewValue() +
					"' room = '" + ((MeetMeUser) evt.getSource()).getRoom() + "'");	
			
			log.info("New data mute = " + changedUser.isMuted());		
			
//			MeetMeUserVo userVo = new MeetMeUserVo(changedUser);
//			
//			List <Object>args1 = new ArrayList<Object>();
//			args1.add(userVo);			
//			so.sendMessage("newStatus", args1);
			
			if (evt.getPropertyName().equals("muted")) {
				List <Object>args = new ArrayList<Object>();
				args.add(changedUser.getUserNumber());
				args.add(changedUser.isMuted());
				so.sendMessage("userMute", args);
				
				log.info("User mute event: [" + changedUser.getUserNumber() 
						+ "," + changedUser.isMuted() + "]");
			} else if (evt.getPropertyName().equals("talking")) {
				List <Object>args = new ArrayList<Object>();
				args.add(changedUser.getUserNumber());
				args.add(changedUser.isTalking());
				so.sendMessage("userTalk", args);
				
				log.info("User talk event: [" + changedUser.getUserNumber() 
						+ "," + changedUser.isTalking() + "]");
			} else if ("state".equals(evt.getPropertyName())) {
				log.info("User is changing state to [" + evt.getNewValue() + "]");
				
				List <Object>args = new ArrayList<Object>();
				args.add(changedUser.getUserNumber());
				if (MeetMeUserState.LEFT == (MeetMeUserState) evt.getNewValue()) {
					so.sendMessage("userLeft", args);
				}
			}			
		}    
	}

	public void setVoiceService(AsteriskVoiceService voiceService) {
		this.voiceService = voiceService;
	}
}
