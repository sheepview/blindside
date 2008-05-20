package org.blindsideproject.asterisk.meetme;

import java.beans.PropertyChangeListener;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.asteriskjava.live.ManagerCommunicationException;
import org.asteriskjava.live.MeetMeUser;
import org.blindsideproject.asterisk.IConference;
import org.blindsideproject.asterisk.IParticipant;


public class MeetMeUserConverter implements IParticipant {
	protected static Logger log = LoggerFactory.getLogger(MeetMeUserConverter.class);
	
	private MeetMeUser user;
	
	public MeetMeUserConverter(MeetMeUser user) {
		this.user = user;
	}
	
	public String getCallerIdName() {
		return user.getChannel().getCallerId().getName();
	}

	public String getCallerIdNumber() {
		return user.getChannel().getCallerId().getNumber();
	}

	public IConference getConference() {
		return new MeetMeRoomAdapter(user.getRoom());
	}

	public Date getDateJoined() {
		return user.getDateJoined();
	}

	public Date getDateLeft() {
		return user.getDateLeft();
	}

	public Integer getParticipantId() {
		return user.getUserNumber();
	}
	
	public boolean isMuted() {
		return user.isMuted();
	}

	public boolean isTalking() {
		return user.isTalking();
	}

	public void kick() {
		try {
			user.kick();
		} catch (ManagerCommunicationException e) {
			log.error("Failed to kick participant: " + user.getUserNumber() + " due to '" + e.getMessage() + "'");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void mute() {
		try {
			user.mute();
		} catch (ManagerCommunicationException e) {
			log.error("Failed to mute participant: " + user.getUserNumber() + " due to '" + e.getMessage() + "'");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void unmute() {
		try {
			user.unmute();
		} catch (ManagerCommunicationException e) {
			log.error("Failed to unmute participant: " + user.getUserNumber() + " due to '" + e.getMessage() + "'");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void addPropertyChangeListener(PropertyChangeListener listener) {
		user.addPropertyChangeListener(listener);
	}
}
