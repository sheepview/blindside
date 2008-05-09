package login;

import java.io.FileWriter;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

import org.springframework.core.io.Resource;
import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.helpers.XMLReaderFactory;

/**
 * The LoginLookup class is a subclass of the Java SAX XML reader. It reads the password file
 * and stores it in a Map.
 * @author dzgonjan
 *
 */
public class LoginLookup extends DefaultHandler{

	private XMLReader xr;
	private Resource userFile;
	private PrintWriter outputStream;

	private HashMap<String, String> users = new HashMap<String, String>();

	/**
	 * The LoginLookup constructor
	 * @param userFile - The red5 resource file in the scope of the application
	 */
	public LoginLookup(Resource userFile){
		super();
		this.userFile = userFile;
	}

	public LoginLookup() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * Parses the whole xml file and stores it in a HashMap
	 */
	public void readFile(){
		try{
			//The following 3 lines are just debug code. They appear in the re5 command window
			System.out.println(this.userFile.getFilename());
			System.out.println(this.userFile.exists());
			System.out.println(this.userFile.getURL());

			InputStream xmlStream = this.userFile.getInputStream();
			xr = XMLReaderFactory.createXMLReader();
			xr.setContentHandler(this);
			xr.setErrorHandler(this);
			xr.parse(new InputSource(xmlStream));
		} catch(Exception e){
			e.printStackTrace();
			System.out.println("ERROR!");
		}
	}

	@Override
	public void startDocument(){

	}

	@Override
	public void endDocument(){

	}

	@Override
	public void startElement (String uri, String name,
			String qName, Attributes atts)
	{
		if (name.equals("user")){
			addUser(atts);
			System.out.println(atts.getValue(0));
			System.out.println(atts.getValue(1));
		}
	}

	@Override
	public void endElement (String uri, String name, String qName)
	{

	}

	@Override
	public void characters (char ch[], int start, int length)
	{
	}

	/**
	 * Adds a user to the password HashMap
	 * @param atts
	 */
	private void addUser(Attributes atts){
		this.users.put(atts.getValue(0), atts.getValue(1));
	}

	/**
	 * Adds a user to the password HashMap
	 * @param name
	 * @param password
	 */
	public boolean addUser(String name, String password){
		if (this.users.containsKey(name)){
			return false;
		}
		this.users.put(name, password);
		return true;
	}

	/**
	 * Checks if the specified user exists
	 * @param loginRequest - The LoginRequest object containing user information
	 * @return
	 */
	public boolean checkUser(LoginRequest loginRequest){
		System.out.println("Client - Name: " + loginRequest.getName() + " ,Password: " + loginRequest.getPassword() );
		System.out.println("Server - Contains: " + users.containsKey(loginRequest.getName()) + " ,Password: " + users.get(loginRequest.getName()) );
		if (this.users.containsKey(loginRequest.getName())){
			return this.users.get(loginRequest.getName()).equals(loginRequest.getPassword());
		} else{
			return false;
		}
	}
	
	/**
	 * Saves the HashMap contained in this object to an xml file within the scope of this
	 * application
	 * @param file the name of the file to which the Map is to be saved
	 */
	public void saveToFile(String file){
		try{
			this.outputStream = new PrintWriter(new FileWriter(file));
			//Object[] keys = users.keySet().toArray();
			//String[] values = users.values().toArray();
			outputStream.println("<Root>");
			Set<String> keys = users.keySet();
			Iterator<String> keyIterator = keys.iterator();
			Collection<String> values = users.values();
			Iterator<String> valueIterator = values.iterator();
			while (keyIterator.hasNext()){
				outputStream.println("\t<user name=\"" + keyIterator.next() + "\" password=\"" + valueIterator.next() + "\">");
				
			}
			outputStream.println("</Root>");
		} catch (Exception e){
			e.printStackTrace();
		} finally{
			if (outputStream != null) {
				outputStream.close();
			}
		}
	}

}
