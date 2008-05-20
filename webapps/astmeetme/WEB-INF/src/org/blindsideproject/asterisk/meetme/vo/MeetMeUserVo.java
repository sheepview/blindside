package org.blindsideproject.asterisk.meetme.vo;

import java.util.Date;

import org.asteriskjava.live.MeetMeUser;

public class MeetMeUserVo {

	private String roomNumber;
	private String callerIdName;
	private String callerIdNumber;
	private Date dateJoined;
	private Date dateLeft;
	private Integer userNumber;
	private Boolean muted;
	private Boolean talking;
	
	public MeetMeUserVo(MeetMeUser user) {
		copy(user);
	}

	public String getCallerIdName() {
		return callerIdName;
	}

	public String getCallerIdNumber() {
		return callerIdNumber;
	}

	public Date getDateJoined() {
		return dateJoined;
	}

	public Date getDateLeft() {
		return dateLeft;
	}

	public Boolean getMuted() {
		return muted;
	}

	public String getRoomNumber() {
		return roomNumber;
	}

	public Boolean getTalking() {
		return talking;
	}

	public Integer getUserNumber() {
		return userNumber;
	}	
	
	private void copy(MeetMeUser userToCopy) {
		callerIdName = userToCopy.getChannel().getCallerId().getName();;
		callerIdNumber = userToCopy.getChannel().getCallerId().getNumber();
		roomNumber = userToCopy.getRoom().getRoomNumber();
		dateJoined = userToCopy.getDateJoined();
		dateLeft = userToCopy.getDateLeft();
		userNumber = userToCopy.getUserNumber();
		muted = userToCopy.isMuted();
		talking = userToCopy.isTalking();
	}	
}
