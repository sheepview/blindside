package org.blindsideproject.presentation;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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
	
	protected static Logger log = LoggerFactory.getLogger( Application.class );

	private static IScope appScope;

	private ConversionUpdatesListener updatesListener;
	
    @Override
    public boolean appStart (IScope app )
    {
    	super.appStart(app);
    	
        log.info( "Presentation::appStart - " );
        appScope = app;
    
        return true;
    }
    
    private void initialize() 
    {	

    }

    public void appStop ( )
    {
        log.info( "Presentation::Stopping" );
    }

    public boolean appConnect( IConnection conn , Object[] params )
    {
    	super.appConnect(conn, params);
    	
        log.info( "Presentation::appConnect - " + conn.getClient().getId() );

//        initialize();       
        
//        boolean accept = ((Boolean)params[0]).booleanValue();

//        if ( !accept ) rejectClient( "you passed false..." );

        return true;
    }

    public void appDisconnect( IConnection conn)
    {
        log.info( "Presentation::appDisconnect - " + conn.getClient().getId() );
    }
    
    public boolean roomStart(IScope room) {
    	log.info( "Presentation::roomStart - " + room.getName() );
    	if (!super.roomStart(room))
    		return false;

    	initialize();
    	return true;
    }
    
    public boolean roomConnect(IConnection conn, Object[] params) {
    	super.roomConnect(conn, params);
    	
    	log.info( "Presentation::roomConnect " + conn.getClient().getId() );
    	if (!hasSharedObject(conn.getScope(), "presentationSO")) {
    		createSharedObject(conn.getScope(), "presentationSO", false);
    		ISharedObject so = getSharedObject(conn.getScope(), "presentationSO", false);
    		updatesListener.addRoom(new Integer(conn.getScope().getName()), so);
    	} else {        	
        	ISharedObject so = getSharedObject(conn.getScope(), "presentationSO", false);        	   		
    	}

    	return true;
    }
    
    public void roomLeave(IClient client, IScope room) {
    	super.roomLeave(client, room);
    	
    	log.info("Presentation::roomLeave - " + client.getId());
    }
    
    public boolean roomJoin(IClient client, IScope room) {
    	super.roomJoin(client, room);    	
    	log.info("Presentation::roomJoin - " + client.getId());
	
    	return true;
    }
    
	public void resultReceived(IPendingServiceCall call) {
		log.info("Received result " + call.getResult() + " for "
				+ call.getServiceMethodName());
	}

	public void setUpdatesListener(ConversionUpdatesListener updatesListener) {
		this.updatesListener = updatesListener;
	}
   
}
