/*
  JIAXClient.java
  Copyright (C) 2004-2005  Mikael Magnusson <mikma@users.sourceforge.net>
  
  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.
  
  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
  
  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

package net.sourceforge.iaxclient;

import java.io.IOException;
import java.io.File;
import java.net.MalformedURLException;
import java.net.SocketPermission;
import java.net.URL;
import java.security.AccessController;
import java.security.AccessControlContext;
import java.security.PrivilegedAction;
import java.security.PrivilegedActionException;
import java.security.PrivilegedExceptionAction;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.EventObject;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.HashSet;
import java.util.List;
import java.util.Vector;
import net.sourceforge.iaxclient.jni.AudioDevice;
import net.sourceforge.iaxclient.jni.IAXEvent;
import net.sourceforge.iaxclient.jni.NetStat;
import net.sourceforge.iaxclient.jni.LibJiaxc;

public class JIAXClient extends LibJiaxc implements Runnable {
    private static String libName = "jiaxc";
    private static URL codeBase;
    private static JIAXClient client;
    private static LibInstaller installer;
    private Thread eventThread;
    private Vector listeners;
    private List calls;
    private Map registrations;
    private AudioDevice audioDevices[];

    public static JIAXClient getInstance() {
    	if (client == null) {
    		loadLibrary();

    		client = new JIAXClient();
    	}

    	return client;
    }

    public int initialize(int audType, int nCalls) {
    	SecurityManager security = System.getSecurityManager();
    	if (security != null) {
    		trace("checkListen");
    		security.checkListen(DEFAULT_PORTNO);
    	} else {
    		trace("not checkListen");
    	}

    	calls = new ArrayList(nCalls);
    	for (int i = 0; i < nCalls; i++) {
    		Call call = new Call(i);
    		calls.add(call);
    	}

    	registrations = new HashMap(1);

    	int res = super.initialize(audType, nCalls);

    	if (res >= 0) {
    		audioDevices = getAudioDevices();
    	}

    	return res;
    }

    public int startProcessingThread()
    {
	if (eventThread == null) {
	    eventThread = new Thread(this);
	    eventThread.start();
	    return super.startProcessingThread();
	} else {
	    return -1;
	}
    }

    public int stopProcessingThread()
    {
	int res = super.stopProcessingThread();

	try {
	    if (eventThread != null) {
		trace("pre joining JIAXClient thread");
		eventThread.join(10000);
		trace("post joining JIAXClient thread");
		eventThread = null;
	    }
	} catch(InterruptedException e) {
	    e.printStackTrace();
	}

	return res;
    }

    public void call(String num)
    {
	// [<user>[:<secret>]@]<peer>[:<portno>][/<exten>[@<context>]] 
	int slashIdx = num.lastIndexOf('/');
	String account;
	String ext;

	if (slashIdx < 0) {
	    account = num;
	    ext = "";
	} else {
	    account = num.substring(0, slashIdx);
	    ext = num.substring(slashIdx + 1);
	}

	int atIdx = account.lastIndexOf('@');
	String reg;
	String host;

	if (atIdx < 0) {
	    reg = "";
	    host = account;
	} else {
	    reg = account.substring(0, atIdx);
	    host = account.substring(atIdx + 1);
	}

	int colIdx = reg.indexOf(':');
	String user;
	String pass;

	if (colIdx < 0) {
	    user = reg;
	    pass = "";
	} else {
	    user = reg.substring(0, colIdx);
	    pass = reg.substring(colIdx + 1);
	}

	int portIdx = host.lastIndexOf(':');
	int port;

	if (portIdx < 0) {
	    port = DEFAULT_PORTNO;
	} else {
	    String portStr = host.substring(portIdx + 1);
	    port = Integer.parseInt(portStr);
	    host = host.substring(0, portIdx);
	}

	trace(account + "," +
	      ext + "," +
	      reg + "," +
	      host + "," +
	      port + "," +
	      user + "," +
	      pass);

	SecurityManager security = System.getSecurityManager();
	if (security != null) {
	    trace("checkConnect: " + host + ":" + port);
	    security.checkConnect(host, port);
	} else {
	    trace("not checkConnect");
	}

	super.call(num);
    }

    public Registration register(String user, String pass, String host)
    {
	String hostName;
	int portIdx = host.lastIndexOf(':');
	int port = DEFAULT_PORTNO;

	if (portIdx >= 0) {
	    String portStr = host.substring(portIdx + 1);
	    port = Integer.parseInt(portStr);
	    hostName = host.substring(0, portIdx);
	} else {
	    hostName = host;
	}

	trace("trying: " + hostName + ":" + port);

	SecurityManager security = System.getSecurityManager();
	if (security != null) {
	    trace("checkConnect");
	    security.checkConnect(hostName, port);
	} else {
	    trace("not checkConnect");
	}

	trace("register: " + user + "@" + host);
	int id = super.registerId(user, pass, host);

	if (id > 0) {
	    Registration reg = new Registration(id, user, pass, host);
	    registrations.put(new Integer(id), reg);

	    return reg;
	}

	return null;
    }

    public int unregister(Registration reg)
    {
	int id = reg.getId();
	int res = -1;

	if (id > 0) {
	    res = super.unregisterId(id);
	}

	trace("unregister: " + id + ">" + res);

	return res;
    }

    public void answerCall(Call c)
    {
	answerCall(getCallNo(c));
    }

    public void blindTransferCall(Call c, String number)
    {
	blindTransferCall(getCallNo(c), number);
    }

    public void rejectCall(Call call)
    {
	Call curr = getSelectedCall();

	rejectCallNumber(call.getCallNo());
    }

    public void sendDtmf(String digits)
    {
	for (int i = 0; i < digits.length(); i++) {
	    sendDtmf(digits.charAt(i));
	}
    }

    public void sendUrl(URL url, boolean link) {
	sendUrlStr(url.toString(), link);
    }

    public void selectCall(Call c) 
    {
	selectCall(getCallNo(c));
    }

    public Call getFirstFreeCall()
    {
	return getCall(firstFreeCallNo());
    }

    public Call getSelectedCall() {
	return getCall(selectedCallNo());
    }

    public void quelch(Call c, int MOH)
    {
	quelch(getCallNo(c), MOH);
    }

    public void unquelch(Call c)
    {
	unquelch(getCallNo(c));
    }

    public String getJIAXVersion()
    {
	return Config.packageVersion;
    }

    public AudioDevice getAudioInput()
    {
	return audioDevices[getAudioInputDevice()];
    }

    public AudioDevice getAudioOutput()
    {
	return audioDevices[getAudioOutputDevice()];
    }

    public AudioDevice getAudioRing()
    {
	return audioDevices[getAudioRingDevice()];
    }

    public void setAudioDevices(AudioDevice input, AudioDevice output,
				AudioDevice ring)
    {
	super.setAudioDevices(input.getDevID(), output.getDevID(),
			      ring.getDevID());
    }

    public void playSound(Sound sound, boolean ring) {
	if (sound.getData() == null) {
	    return;
	}

	trace("playSound " + sound
	      + " rep:" + sound.getRepeat()
	      + " ring:" + ring);
	//	      + " len:" + sound.getData().length);
	int id = playSound(sound.getData(), sound.getRepeat(), ring);
	sound.setId(id);
    }

    public void stopSound(Sound sound) throws IllegalArgumentException
    {
	int id = sound.getId();
	
	trace("stopSound " + sound + " id:" + id);
	if (id > 0) {
	    stopSound(id);
	}
    }

    public synchronized void addIAXListener(IAXListener l) {
	if (l != null) {
	    listeners.addElement(l);
	}
    }

    public synchronized void removeIAXListener(IAXListener l) {
	if (l != null) {
	    listeners.removeElement(l);
	}
    }

    public static void setCodeBase(URL url) {
	codeBase = url;
    }

    public void run() {
	while (true) {
	    EventObject event;

	    try {
		//trace("getNextEvent calling " + this);
		event = getNextEvent();
		//trace("getNextEvent:" + event + " " + this);
		processIAXEvent((IAXEvent)event);
	    } catch(InterruptedException e) {
		//e.printStackTrace();
		return;
	    } catch (Exception e) {
		e.printStackTrace();
	    }
	}
    }

    protected JIAXClient() {
	listeners = new Vector();
    }

    protected IAXEvent
	createCallStateEvent(long date, int callNo, int state, 
			     String remove, String removeName,
			     String local, String localName) {
// 	Call c;

// 	try {
// 	    c = getCall(callNo);
// 	} catch(IndexOutOfBoundsException e) {
// 	    c = new Call(callNo);
// 	    calls.add(c);
// 	}

	Call call = getCall(callNo);
	CallState newState = new CallState(state);

 	return new CallStateEvent(this, date, call, newState, remove,
 				  removeName, local, localName);
    }

    protected IAXEvent createTextEvent(long date, int type, int callNo,
				       String message) {
	Call call = null;

	if (type == TEXT_TYPE_IAX) {
	    call = getCall(callNo);
	}
	return new TextEvent(this, date, type, call, message);
    }

    protected IAXEvent createLevelsEvent(long date,
					 float input, float output) {
	return new LevelsEvent(this, date, input, output);
    }

    protected NetStat createNetStat(int jitter, int losspct,
				    int losscnt, int packets,
				    int delay, int dropped, int ooo)
    {
	return new NetStat(jitter, losspct, losscnt, packets,
			   delay, dropped, ooo);
    }

    protected IAXEvent createNetStatsEvent(long date, int callNo, int rtt,
					   NetStat local, NetStat remote)
    {
	Call call = getCall(callNo);
	
	return new NetStatsEvent(this, date, call, rtt, local, remote);
    }

    protected IAXEvent createUrlEvent(long date, int type, int callNo,
				       String message) {
	Call call = null;
	URL url = null;

	call = getCall(callNo);

	try {
	    if (message != null) {
		url = new URL(message);
	    }
	} catch(MalformedURLException e) {
	    System.out.println(e);
	}

	return new UrlEvent(this, date, type, call, url);
    }

    protected IAXEvent createRegistrationEvent(long date, int id, int reply,
					       int msgcount)
    {
	Registration reg = null;

	reg = getRegistration(id);

	return new RegistrationEvent(this, date, reg, reply, msgcount);
    }

    protected AudioDevice createAudioDevice(String name,
						   long capabilities,
						   int devID) {
	return new AudioDevice(name, capabilities, devID);
    }

    protected synchronized void processIAXEvent(IAXEvent event)
    {
	Enumeration e = listeners.elements();

	while (e.hasMoreElements()) {
	    IAXListener listener = (IAXListener)e.nextElement();
	    
	    if (event instanceof LevelsEvent) {
		listener.levelsChanged((LevelsEvent)event);
	    }
	    else if (event instanceof CallStateEvent) {
		CallStateEvent stateEvent = (CallStateEvent)event;
		listener.call(stateEvent);
	    }
	    else if (event instanceof TextEvent) {
		TextEvent textevent = (TextEvent)event;
		listener.textReceived(textevent);
	    }
	    else if (event instanceof NetStatsEvent) {
		NetStatsEvent statsEvent = (NetStatsEvent)event;
		listener.netStatsReceived(statsEvent);
	    }
	    else if (event instanceof UrlEvent) {
		UrlEvent urlEvent = (UrlEvent)event;

		switch(urlEvent.getType()) {
		case URL_URL:
		    listener.received(urlEvent);
		    break;
		case URL_LDCOMPLETE:
		    listener.loadingComplete(urlEvent);
		    break;
		case URL_LINKURL:
		    listener.linkRequest(urlEvent);
		    break;
		case URL_LINKREJECT:
		    listener.linkReject(urlEvent);
		    break;
		case URL_UNLINK:
		    listener.unlink(urlEvent);
		    break;
		}
	    } else if (event instanceof RegistrationEvent) {
		RegistrationEvent regEvent = (RegistrationEvent)event;

		switch(regEvent.getReply()) {
		case IAXC_REGISTRATION_REPLY_ACK:
		    listener.regAcknowledged(regEvent);
		    break;
		case IAXC_REGISTRATION_REPLY_REJ:
		    listener.regRejected(regEvent);
		    break;
		case IAXC_REGISTRATION_REPLY_TIMEOUT:
		    listener.regTimedout(regEvent);
		    break;
		}

		trace("Reg: " + regEvent.getReply());
		//		listener.netStatsReceived(statsEvent);
	    }
	}

	if (event instanceof CallStateEvent) {
	    CallStateEvent stateEvent = (CallStateEvent)event;

	    Call call = stateEvent.getCall();
	    CallState state = stateEvent.getState();
	    
	    call.setState(state);
	}
    }

    static {
	try {
	    PrivilegedAction action =
		new PrivilegedAction() {
		    public Object run() {
			return new LibInstaller();
		    }
		};

	    installer = (LibInstaller)AccessController.doPrivileged(action);
	} catch (UnsatisfiedLinkError e) {
	    e.printStackTrace();
	}
    }

    public static boolean isLibraryLoaded()
    {
    	try {
    		String ver = getVersion();
    		return true;
    	} catch (UnsatisfiedLinkError e) {
	}

	return false;
    }

    // Check if library is up-to-date
    public static boolean checkLibrary()
	throws IOException
    {
    	final String libName = JIAXClient.libName;
    	final LibInstaller installer = JIAXClient.installer;

    	if (isLibraryLoaded())
    		return true;

    	try {
    		PrivilegedExceptionAction action =
    			new PrivilegedExceptionAction() {
    				public Object run() throws Exception {
    					return new Boolean(installer.checkLibrary(libName));
    				}
    			};

    			Boolean res = (Boolean)AccessController.doPrivileged(action);
    			return res.booleanValue();
    	} catch (PrivilegedActionException e) {
    		throw (IOException)e.getCause();
    	}
    }

    // Download and install library
    public static void downloadAndInstallLibrary()
	throws IOException
    {
    	final String libName = JIAXClient.libName;
    	final URL codeBase = JIAXClient.codeBase;
    	final LibInstaller installer = JIAXClient.installer;

    	try {
    		PrivilegedExceptionAction action =
    			new PrivilegedExceptionAction() {
    				public Object run() throws Exception {
    					installer.installLibrary(codeBase, libName);
    					return null;
    				}
    			};

    			AccessController.doPrivileged(action);
    	} catch (PrivilegedActionException e) {
    		throw (IOException)e.getCause();
    	}
    }

    protected static void loadLibrary()
    {
    	final String libName = JIAXClient.libName;

    	try {
    		PrivilegedExceptionAction action =
    			new PrivilegedExceptionAction() {
    				public Object run() throws Exception {
    					System.loadLibrary(libName);
    					return null;
    				}
    		};

    		AccessController.doPrivileged(action);
    	} catch (UnsatisfiedLinkError e) {
    		e.printStackTrace();
    	} catch (PrivilegedActionException e) {
    	}
    }

    protected static void trace(String s)
    {
    	System.out.println(s);
    }

    protected int getCallNo(Call call) throws IllegalArgumentException
    {
	return ((Call)call).getCallNo();
    }

    protected Call getCall(int callNo) throws IndexOutOfBoundsException
    {
	return (Call)calls.get(callNo);
    }

    protected Registration getRegistration(int id)
	throws IndexOutOfBoundsException {
	return (Registration)registrations.get(new Integer(id));
    }
}