package org.blindsideproject.conference;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.blindsideproject.conference.vo.Room;

import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IScope;
import org.red5.server.api.service.IPendingServiceCall;
import org.red5.server.api.service.IPendingServiceCallback;
import org.red5.server.api.service.IServiceCapableConnection;
import org.red5.server.api.so.ISharedObject;
import org.springframework.core.io.Resource;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

public class Application extends ApplicationAdapter implements
	IPendingServiceCallback {
	protected static Logger log = LoggerFactory.getLogger( Application.class );

	private static IScope appScope;
	private Map<String, Room> conferenceRooms = new HashMap<String, Room>();
	
	private static final String PARTICIPANTS = "PARTICIPANTS";
	private static final String PARTICIPANTS_SO = "participantsSO";
    @Override
    public boolean appStart (IScope app )
    {
    	//System.out.println("\n\n\n-----------------APPLICATION START-------------------------\n\n\n");
        log.info( "Blindside.appStart" );
        appScope = app;
        
        initialize();
        
        return true;
    }
    
    private void initialize() 
    {
        conferenceRooms = this.loadConferenceRooms("conferences/conferences.xml");

    }

    public void appStop ( )
    {
    	//System.out.println("\n\n\n-----------------APPLICATION STOP-------------------------\n\n\n");
        log.info( "Blindside.appStop" );
    }

    public boolean appConnect( IConnection conn , Object[] params )
    {
    	//System.out.println("\n\n\n-----------------APPLICATION CONNECT-------------------------\n\n\n");
        log.info( "Blindside.appConnect " + conn.getClient().getId() );
    	
        return true;
    }
    
    private Room getRoom(String room)
    {
    	if (! conferenceRooms.containsKey(room)) {
    		return null;
    	}
    	
    	return conferenceRooms.get(room);
    }


    private void setUserIdAndRole(IConnection conn, Role role)
    {
		IServiceCapableConnection service = (IServiceCapableConnection) conn;
		
		log.info("Setting userId and role [" + conn.getClient().getId() + "," + role.toString() + "]");
		
		service.invoke("setUserIdAndRole", new Object[] { conn.getClient().getId(), role.toString() },
						this);
    }

    public void appDisconnect( IConnection conn)
    {
    	//System.out.println("\n\n\n-----------------APPLICATION DISCONNECT-------------------------\n\n\n");
        log.info( "Blindside.appDisconnect " + conn.getClient().getId() );
    }
    
    public boolean roomStart(IScope room) {
    	//System.out.println("\n\n\n-----------------ROOM START-------------------------\n\n\n");
    	log.info( "Blindside.roomStart " );
    	if (!super.roomStart(room))
    		return false;

    	return true;
    }
    
    public boolean roomConnect(IConnection conn, Object[] params) {
    	//System.out.println("\n\n\n-----------------ROOM CONNECT-------------------------\n\n\n");
    	log.info( "Blindside.roomConnect " + conn.getClient().getId() );

    	String room = ((String) params[0]).toString();
        String username = ((String) params[1]).toString();
        String password = ((String) params[2]).toString();

        log.info("User logging [" + room + "," + username + "," + password + "]");

        Room confRoom = getRoom(room);        
        if (confRoom == null) {
        	log.info("Cannot find room[" + room + "]");
        	rejectClient("Room not found.");
        	return true;
        }
        
    	String modPass = confRoom.getModeratorPassword();
    	String viewPass = confRoom.getViewerPassword();
    	
    	if (!(modPass.equals(password)) && !(viewPass.equals(password))) {
    		log.info("Wrong password for [" + room + "," + password + "]");
    		log.info("Passwords are [" + modPass + "," + viewPass + "]");
    		rejectClient("Wrong password.");
    		return true;
    	}
    	
    	Role role = Role.VIEWER;
    	
    	if (modPass.equals(password)) role = Role.MODERATOR;
    	else role = Role.VIEWER;
    	
    	setUserIdAndRole(conn, role);        

    	ISharedObject so = null;
    	
    	if (!hasSharedObject(conn.getScope(), PARTICIPANTS_SO)) {
    		createSharedObject(conn.getScope(), PARTICIPANTS_SO, false);
    		so = getSharedObject(conn.getScope(), PARTICIPANTS_SO, false);
    	} else {        	
        	so = getSharedObject(conn.getScope(), PARTICIPANTS_SO, false);        	   		
    	}    	
    	
    	Participant newParticipant = new Participant(new Integer(conn.getClient().getId()), username, role.toString());

    	confRoom.addParticipant(newParticipant);
    	
    	ArrayList<Participant> participants = confRoom.getParticipants();
      	
    	so.beginUpdate();
    	so.setAttribute(newParticipant.userid.toString(), newParticipant);
    	
    	log.info("Blindside::roomConnect - Adding[" + newParticipant.userid + "," + participants.size() + "]");
    	
//    	so.setAttribute(PARTICIPANTS, participants);
    	so.endUpdate();
    	
    	return true;
    }

    public void roomLeave(IClient client, IScope room) {
    	//System.out.println("\n\n\n-----------------ROOM LEAVE-------------------------\n\n\n");
    	super.roomLeave(client, room);
    	ISharedObject so = getSharedObject(room, PARTICIPANTS_SO, false);
    	
    	Room confRoom = getRoom(room.getName()); 
    	confRoom.removeParticipant(new Integer(client.getId()));

    	ArrayList<Participant> participants = confRoom.getParticipants();
      	
    	so.beginUpdate();
    	so.removeAttribute(client.getId());
    	log.info("Blindside::roomLeave - Removing[" + client.getId() + "," + participants.size() + "]");
//    	so.setAttribute(PARTICIPANTS, participants);
    	so.endUpdate();
    
    }
    
    public boolean roomJoin(IClient client, IScope room) {
    	//System.out.println("\n\n\n-----------------ROOM JOIN-------------------------\n\n\n");
    	super.roomJoin(client, room);    	
    	
    	log.info("Blindside::roomJoin - " + client.getId());
  	
    	return true;
    }    
    
     public Map<String, Room> loadConferenceRooms(String fileName)
     {
    	Map<String, Room> rooms = new HashMap<String, Room>();
    	 
     	try {
     		log.debug("Loading conference rooms");    		
 	    	
     		Resource roomsXML = getResource(fileName);
 			
     		InputStream xmlinStream = roomsXML.getInputStream();
     		BufferedReader xmldataStream = new BufferedReader(new InputStreamReader(xmlinStream));
     		StringBuffer xmlStringBuf = new StringBuffer();
     		
     		String inputLine;
     		
     		while ((inputLine = xmldataStream.readLine()) != null) { 
     			xmlStringBuf.append(inputLine);
     		}
     		
     		xmldataStream.close();

 	    	Document dom = null;    	
 	    	try {
 				dom = this.stringToDoc(xmlStringBuf.toString());
 			} 
 	    	catch (IOException ioex) {
 				log.error("IOException converting xml to dom", ioex);
 			}
 	
 	    	//enables access to the document element of the document...
 	        Element docElement = dom.getDocumentElement();
 	
 	        //get a nodelist of <playlist-item> elements
 	        NodeList nl_level1 = docElement.getElementsByTagName("conference-room");
 	        if(nl_level1 != null && nl_level1.getLength() > 0) {
 	            String roomName;
 	            String modPassword;
 	            String viewPassword;
 	            
 	        	for(int i = 0 ; i < nl_level1.getLength();i++){	                
 	                
 	                Element roomItem_nl_level1 = (Element)nl_level1.item(i);
 	                
 	                //
 	                // Get the values of the <name> and <length> tags within each <playlist-item> 
 	                // and put them into the Map<String, Object> Object...
 	                //
 	                roomName = getTextValue(roomItem_nl_level1, "name");	                
 	                modPassword = getTextValue(roomItem_nl_level1, "mod-password");	              
 	                viewPassword = getTextValue(roomItem_nl_level1, "view-password");
 	               
 	                log.debug("Item no:"+i+", Name: "+ roomName + ", moderator: "+ modPassword + ", viewer: " + viewPassword);
 	                
 	                Room room = new Room(roomName, modPassword, viewPassword);
 	                 	     			
 	     			rooms.put(roomName, room);
 	            }
 	        }
     	}
     	catch (IOException ioe){
     		log.debug(ioe.toString());
     	}

     	return rooms;

     }  
     
     /**
      * This method returns the the string value within an Element's tag
      * @param ele
      * 		A DOM <code>Element</code>
      * @param tagName
      * 		The name of the DOM Element of type <code>String</code>
      * @return
      * 		The value contained within the DOM Element. Return value is of type <code>String</code>.
      * 
      */
     private String getTextValue(Element ele, String tagName)
     {
         String textVal = null;
         NodeList nl = ele.getElementsByTagName(tagName);
         
         if(nl != null && nl.getLength() > 0)
         {
             Element el = (Element)nl.item(0);
             textVal = el.getFirstChild().getNodeValue();
         }

         return textVal;
     }
     
     /**
      * This method takes in an XML string and returns a DOM...
      * @param element
      * 		<code>String</code> name of the file
      * @return
      * 		A DOM object created by the SAX parser
      * 
      */
     public Document stringToDoc(String str) throws IOException 
     {
     	try {
 	    	DocumentBuilder db = DocumentBuilderFactory.newInstance().newDocumentBuilder();
 	    	return db.parse(new InputSource(new StringReader(str)));
 	    }
     	catch(Exception ex){
 	    	log.debug("Error in stringToDoc() converting from xml sting to xml doc "+ex.toString());
 	    	return null;
 	    }
 	 }     
     
	public void resultReceived(IPendingServiceCall call) {
		log.info("Received result " + call.getResult() + " for "
				+ call.getServiceMethodName());		
	}     
}
