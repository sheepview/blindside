package org.blindsideproject.asterisk.meetme;

import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.asteriskjava.live.MeetMeUser;
import org.asteriskjava.live.MeetMeUserState;

public class ParticipantPropertyChangeListener implements PropertyChangeListener {
	private final Log log = LogFactory.getLog(getClass());
	
	private String roomNumber;
	private MeetMeUserAdapter user;
	
	public ParticipantPropertyChangeListener(String roomNumber, MeetMeUserAdapter user) {
		this.roomNumber = roomNumber;
		this.user = user;
	}
	
	public void propertyChange(PropertyChangeEvent evt) {
		MeetMeUser changedUser = (MeetMeUser) evt.getSource();
		String room = changedUser.getRoom().getRoomNumber();
		
		log.info("Received property changed event for " + evt.getPropertyName() +
				" old = " + evt.getOldValue() + " new = " + evt.getNewValue() +
				" room = " + ((MeetMeUser) evt.getSource()).getRoom());	
		
		
		if (roomNumber.equals(room)) {		
/*			if ("state".equals(evt.getPropertyName()) && 
					(evt.getNewValue().equals(MeetMeUserState.JOINED))) {
				if (user == changedUser) {
					log.info("User left the conference...");
					changedUser.removePropertyChangeListener(this);
				}
			}
*/	
		}
	}

}
