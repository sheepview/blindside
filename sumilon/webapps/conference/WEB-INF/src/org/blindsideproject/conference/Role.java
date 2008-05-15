package org.blindsideproject.conference;

public enum Role {
	VIEWER (0, "VIEWER"),
	MODERATOR (1, "MODERATOR"),
	ADMINISTRATOR (2, "ADMINISTRATOR");
	
	private final String role;
	private final int value;
	
	Role(int value, String role) {
		this.value = value;
		this.role = role;
	}
	
	public String toString() {
		return role;
	}
	
	public int value() {
		return value;
	} 
}
