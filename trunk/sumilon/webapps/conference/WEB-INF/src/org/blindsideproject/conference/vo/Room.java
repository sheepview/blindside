package org.blindsideproject.conference.vo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.blindsideproject.conference.Participant;

public class Room {
	private static final Log log = LogFactory.getLog( Room.class );
	
	private String room;
	private String moderatorPassword;
	private String viewerPassword;

	private Map <Integer, Participant> participants = new HashMap<Integer, Participant>();
	
	public Room(String room, String modPass, String viewPass)
	{
		this.room = room;
		this.moderatorPassword = modPass;
		this.viewerPassword = viewPass;
	}

	public String getModeratorPassword() {
		return moderatorPassword;
	}

	public String getRoom() {
		return room;
	}

	public String getViewerPassword() {
		return viewerPassword;
	}
	
	public void addParticipant(Participant participant) {
		participants.put(participant.userid, participant);
		log.debug("Added participant[" + participant.userid + "," + 
				participants.size() + "]");
	}
	
	public void removeParticipant(Integer userid) {
		participants.remove(userid);
	}
	
	public ArrayList<Participant> getParticipants() {
		return new ArrayList<Participant>(participants.values());
	}	
}
