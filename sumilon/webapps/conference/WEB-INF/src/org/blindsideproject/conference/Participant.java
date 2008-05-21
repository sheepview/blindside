package org.blindsideproject.conference;

public class Participant {

	public Integer userid;
	public String name;
	public String role = Role.VIEWER.toString();
	public String status = "";
	public Boolean hasStream = new Boolean(false);
	public String streamName = "";
		
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
