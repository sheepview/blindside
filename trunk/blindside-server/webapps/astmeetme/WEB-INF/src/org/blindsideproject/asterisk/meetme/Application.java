package org.blindsideproject.asterisk.meetme;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.asteriskjava.live.ManagerCommunicationException;
import org.asteriskjava.live.MeetMeUser;
import org.blindsideproject.asterisk.AsteriskVoiceService;

import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.Red5;
import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IScope;
import org.red5.server.api.service.IPendingServiceCall;
import org.red5.server.api.service.IPendingServiceCallback;
import org.red5.server.api.service.IServiceCapableConnection;
import org.red5.server.api.so.ISharedObject;

public class Application extends ApplicationAdapter implements
		IPendingServiceCallback	{
	
    private static final Log log = LogFactory.getLog( Application.class );

	private static IScope appScope;

	private AsteriskVoiceService voiceService;
	private ConferenceRoomListener roomListener;
	
    @Override
    public boolean appStart (IScope app )
    {
    	super.appStart(app);
    	
        log.info( "MeetMe::appStart - " );
        appScope = app;
    
        return true;
    }
    
    private void initialize() 
    {	
 //   	roomListener = new ConferenceRoomListener();
    	try {
			voiceService.addAsteriskServerListener(roomListener);
		} catch (ManagerCommunicationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
    }

    public void appStop ( )
    {
        log.info( "Asterisk Meetme Stopping" );
    }

    public boolean appConnect( IConnection conn , Object[] params )
    {
    	super.appConnect(conn, params);
    	
        log.info( "MeetMe::appConnect - " + conn.getClient().getId() );

//        initialize();       
        
//        boolean accept = ((Boolean)params[0]).booleanValue();

//        if ( !accept ) rejectClient( "you passed false..." );

        return true;
    }

    public void appDisconnect( IConnection conn)
    {
        log.info( "MeetMe::appDisconnect - " + conn.getClient().getId() );
    }
    
    public boolean roomStart(IScope room) {
    	log.info( "MeetMe::roomStart - " + room.getName() );
    	if (!super.roomStart(room))
    		return false;

    	initialize();
    	return true;
    }
    
    public boolean roomConnect(IConnection conn, Object[] params) {
    	super.roomConnect(conn, params);
    	
    	log.info( "MeetMe::roomConnect " + conn.getClient().getId() );
    	
    	if (!hasSharedObject(conn.getScope(), "meetMeUsersSO")) {
    		createSharedObject(conn.getScope(), "meetMeUsersSO", false);
    		ISharedObject so = getSharedObject(conn.getScope(), "meetMeUsersSO", false);
    		roomListener.addRoom(conn.getScope().getName(), so);
    	} else {        	
        	ISharedObject so = getSharedObject(conn.getScope(), "meetMeUsersSO", false);        	   		
    	}

    	return true;
    }

    
    public void roomLeave(IClient client, IScope room) {
    	super.roomLeave(client, room);
    	
    	log.info("MeetMe::roomLeave - " + client.getId());
    }
    
    public boolean roomJoin(IClient client, IScope room) {
    	super.roomJoin(client, room);    	
    	log.info("MeetMe::roomJoin - " + client.getId());
	
    	// get the current scope that the current connection is associated with...
    	IScope scope = Red5.getConnectionLocal().getScope();
    	String roomNumber = scope.getName();
    	
		IServiceCapableConnection service = (IServiceCapableConnection) Red5.getConnectionLocal();
		service.invoke("setRoomNumber", new Object[] { roomNumber },
						this);     	
 	
    	return true;
    }
    
    public double add(double a, double b){
        return a + b;
    }

	public void setVoiceService(AsteriskVoiceService voiceService) {
		log.debug("Setting voice Services...");
		this.voiceService = voiceService;
	}

	public void setRoomListener(ConferenceRoomListener roomListener) {
		this.roomListener = roomListener;	
	}

	public void resultReceived(IPendingServiceCall call) {
		log.info("Received result " + call.getResult() + " for "
				+ call.getServiceMethodName());
	}
   
}
