package org.blindsideproject.conference.vo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.blindsideproject.conference.Participant;
/**
 * Room class is an entity class used to create instances that can keep details about each conference room.
 *  
 * @author ritzalam
 *
 */
public class Room {
	private static final Log log = LogFactory.getLog( Room.class );
	/**
	 * Conference room name
	 */
	private String room;
	private String moderatorPassword;
	private String viewerPassword;
	/**
	 * List of participants of the conference room
	 */ 
	private Map <Integer, Participant> participants = new HashMap<Integer, Participant>();
	
	/**
	 * Constructor
	 * @param room conference room ID
	 * @param modPass moderator password
	 * @param viewPass viewer password 
	 * 
	 */
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
	/**
	 * This method adds new participants to the list of participants of the conference room
	 * @param participant
	 */
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
