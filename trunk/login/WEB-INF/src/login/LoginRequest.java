package login;

/**
 * The LoginRequest is a simple class which holds a users credentials
 * @author dzgonjan
 *
 */
public class LoginRequest {
	
	private String name;
	private String password;
	
	/**
	 * Default constructor. Holds a user name and password
	 * @param name - the username
	 * @param password - the password
	 */
	public LoginRequest(String name, String password){
		this.name = name;
		this.password = password;
	}
	
	/**
	 * @return the user name contained in this object
	 */
	public String getName(){
		return this.name;
	}
	
	/**
	 * @return the password contained in this object
	 */
	public String getPassword(){
		return this.password;
	}
}
