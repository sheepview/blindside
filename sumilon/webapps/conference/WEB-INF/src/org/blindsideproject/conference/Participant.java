package org.blindsideproject.conference;

/**
 * Participant class is an entity class used to create instances that can keep details about each participant of conference rooms.
 *  
 * @author ritzalam
 *
 */
public class Participant {

	public Integer userid;
	public String name;
	public String role = Role.VIEWER.toString();
	public String status = "";
	public Boolean hasStream = new Boolean(false);
	public String streamName = "";
	/**
	 * Constructor for participant class.
	 * @param userid - client ID
	 * @param name - name of the participant
	 * @param role - Role in the conference room
	 */	
	public Participant(Integer userid, String name, String role) {
		this.userid = userid;
		this.name = name;
		this.role = role;
	}
	
	public Integer getUserid() {
		return userid;
	}
	
	public String getName() {
		return name;
	}
	
	public String getRole() {
		return role;
	}
}
