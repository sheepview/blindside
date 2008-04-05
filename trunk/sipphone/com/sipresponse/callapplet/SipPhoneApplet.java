package com.sipresponse.callapplet;


import java.io.*;
import java.net.InetAddress;
import java.net.UnknownHostException;
import com.sipresponse.flibblecallmgr.CallManager;
import com.sipresponse.flibblecallmgr.Event;
import com.sipresponse.flibblecallmgr.EventCode;
import com.sipresponse.flibblecallmgr.EventType;
import com.sipresponse.flibblecallmgr.FlibbleListener;
import com.sipresponse.flibblecallmgr.MediaSourceType;

import java.applet.*; 
import java.awt.Button;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class SipPhoneApplet extends Applet implements FlibbleListener, ActionListener
{
    
	private static final long serialVersionUID = -3888677359427519327L;
	
	private CallManager callMgr = new CallManager();
    private String lineHandle = null;
    private String callHandle = null;
    private boolean inCall = false;
    private boolean registered = false;
    private final String DEFAULT_USER = "nitin";
    private final String DEFAULT_PASS = "ff3j";
    private final String DEFAULT_HOST = "134.117.254.226";
    private final int DEFAULT_PORT = 5060;
    private final int DEFAULT_NUMBER = 85115;
    
    private final boolean DEFAULT_REGISTER = true;

    private final String DEFAULT_CALLERID = "Nitin";
    private final String DEFAULT_CALLERNUM = "Nitin";

    private String user;        
    private String pass;        
    private String host;        
    private int port; 
    private int number;
    private String callerid ;        
    private String callernum ;
   
    Button regbutton;
    Button unregbutton;
    
    public void init()     
   { 
        setLayout(new FlowLayout()); 
        regbutton = new Button("Call");
        add(regbutton);
        
        unregbutton = new Button("End Call");
        add(unregbutton);
        

        regbutton.addActionListener(this); 
        
        unregbutton.addActionListener(this);
	   getParameters();
   		connect();   
   }

    public void actionPerformed(ActionEvent evt)  
    { 
 // Here we will ask what component called this method 
         if (evt.getSource() == regbutton)  
  
 	{
        	 call(85115); 
 	}

  
 	if (evt.getSource() == unregbutton)  
     { 
          hangup();
     } 
 }
    
   public String getStringParameter(String name, String def)
   {
       String val;


       
       val = getParameter(name);
       
       if (val != null) {
               return val;
       } else {
               return def;
       }
   }

   public int getIntParameter(String name, int def)
   {
       int res = def;

       String val;

       
     val = getParameter(name);
       
       
       if (val != null) {
               try {
                       res = Integer.parseInt(val);
               } catch (NumberFormatException e) {
               }
       }

       

       return res;
   }
   
   private void getParameters() 
   {       
	   user = getStringParameter("USER", DEFAULT_USER);        
	   pass = getStringParameter("PASS", DEFAULT_PASS);        
	   host = getStringParameter("HOST", DEFAULT_HOST);        
	   port = getIntParameter("PORT", DEFAULT_PORT);   
	   number = getIntParameter("NUMBER", DEFAULT_NUMBER);
	   callerid = getStringParameter("CALLERID", DEFAULT_CALLERID);        
	   callernum = getStringParameter("CALLERNUM", DEFAULT_CALLERNUM); 
   }

   public void start() {        
	   
   }     
   
   public void stop() {        
	   hangup();
   }
   
   public void destroy() {        
	   hangup();
   } 
   
    private void connect()
    {
        try
        {
            callMgr.initialize(InetAddress.getLocalHost().getHostAddress(),  // address to bind to
                    5060, // port to bind to 
                    9300, // start media port range
                    9400, // end media port range
                    host, // proxy address
                    port, // proxy port
                    null, // stun server
                    true, // use sound card
                    null); // media filename
            callMgr.addListener(this);
        }
        
       catch (Exception e1)
        {
            e1.printStackTrace();
        }
        
        // create a registered line
        lineHandle = callMgr.addLine("sip:" + user + "@" + host, user, true, 200, pass);
    }
    
    public void call(int number) 
    {        
    	this.number =  number ;

    	callHandle = callMgr.createCall(lineHandle, "sip:" + number + "@" + host);
        callMgr.placeCall(callHandle,
                MediaSourceType.MEDIA_SOURCE_MICROPHONE,
                null,
                false);
    }

    public boolean onEvent(Event event)
    {
        if (event.getEventType() == EventType.LINE)
        {
            System.err.println("Line Event:  " +  event.getEventCode() + ", " + event.getEventReason());
            
            // place the call if the line is registered
            if (event.getEventCode() == EventCode.LINE_REGISTERED)
            {
            	registered = true;
            }
        }
        else if (event.getEventType() == EventType.CALL)
        {
            if (event.getEventCode() == EventCode.CALL_CONNECTED)
            {
                inCall = true;
            }
            else if (event.getEventCode() == EventCode.CALL_FAILED ||
                event.getEventCode() == EventCode.CALL_DISCONNECTED)
            {
                inCall = false;
            }
        }
        return false;
    }
    
    
        
  
    public void hangup()
    {
    	if (true == inCall)
        {
            callMgr.endCall(callHandle);
            try
            {
                Thread.sleep(4000);
            }
            catch (InterruptedException e)
            {
                e.printStackTrace();
            }
        }
        //callMgr.destroyCallManager();
        //callMgr = null;
    }

    

    }
