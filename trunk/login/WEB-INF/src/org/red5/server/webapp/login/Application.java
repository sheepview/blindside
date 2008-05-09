package org.red5.server.webapp.login;

import login.LoginLookup;
import login.LoginRequest;

import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IScope;
import org.springframework.core.io.Resource;

/**
 *  This is the main class of the server login application for Blindside
 * @author dzgonjan
 *
 */
public class Application extends ApplicationAdapter {
	
	private static final String USERS_XML = "users.xml";
	private LoginLookup lookup;
	public static IScope appScope;
	
	/**
	 * For testing purposes
	 * @param val
	 * @return
	 */
	public String test(String val) {
		log.debug("test called on: " + getName());
		return val + val;
	}
	
	/**
	 * This override method is called when the application first starts
	 * The purpose of the override is that we can save the scope of the application
	 * so that later we can get certain application resources, like files
	 * <p>
	 * This function is called automatically, there is no need to call it directly.
	 */
	public boolean appStart(IScope app){
		appScope = app;
		Resource users = appScope.getResource(USERS_XML);
		this.lookup = new LoginLookup(users);
		this.lookup.readFile();
		return true;
	}
	
	/**
	 * This method saves to file all the usernames and passwords
	 */
	public void saveToFile(){
		this.lookup.saveToFile(USERS_XML);
	}
	
	/**
	 * Dumps all the usernames and passwords to an xml file on the server
	 */
	public void saveAll(){
		this.lookup.saveToFile(appScope.getPath() + USERS_XML);
	}
	
	/**
	 *  The method is called by the client. It requests authentication of the user name and
	 *  password from the server.
	 * @param name The name passed in to the server
	 * @param password The password passed in to the server
	 * @return whether or not the login was authenticated
	 */
	public boolean attemptLogin(String name, String password){
		log.debug("login attempt called on: " + getName());
		return this.lookup.checkUser(new LoginRequest(name, password));
	}
	
	/**
	 * This method is called by the client when a new registration request is received
	 * @param name the name of the new user
	 * @param password the password of the new user
	 * @return whether the registration was completed sucessfully
	 */
	public boolean attemptRegister(String name, String password){
		return this.lookup.addUser(name, password);
	}
}
