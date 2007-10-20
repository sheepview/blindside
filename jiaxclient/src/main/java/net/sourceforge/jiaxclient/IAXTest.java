
/*
  IAXTest.java
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
// Hello
package net.sourceforge.jiaxclient;

import net.sourceforge.iaxclient.jni.AudioDevice;
import net.sourceforge.iaxclient.jni.Constants;
import net.sourceforge.iaxclient.TextEvent;
import net.sourceforge.iaxclient.*;
import java.applet.Applet;
import java.applet.AppletContext;
import java.awt.*;
import java.awt.event.*;
import java.io.IOException;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.FilePermission;
import java.net.MalformedURLException;
import java.net.SocketPermission;
import java.net.URL;
import java.security.AccessController;
import java.security.AccessControlException;
import java.security.PrivilegedAction;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.StringTokenizer;
// import javax.swing.JOptionPane;
import javax.swing.JFrame;
import java.lang.Integer;

public class IAXTest extends Applet implements Constants
{
    private static boolean isApplet = true;
    private static Frame wnd;

    private boolean running = false;

    // Parameters
    private final int DEFAULT_INPUT = -1;
    private final int DEFAULT_OUTPUT = -1;
    private final String DEFAULT_USER = "guest";
    private final String DEFAULT_PASS = "";
    private final String DEFAULT_HOST = "localhost";
    private final int DEFAULT_PORT = 4569;
    private final int DEFAULT_PREFERRED = FORMAT_ALAW;
    private final int DEFAULT_ALLOWED = FORMAT_GSM + FORMAT_ULAW + FORMAT_ALAW + FORMAT_SPEEX;
    private final boolean DEFAULT_REGISTER = true;
    private final String DEFAULT_NUMBER = "510";
    private final String DEFAULT_CALLERID = "Unknown Caller";
    private final String DEFAULT_CALLERNUM = "unknown";

    private int input = DEFAULT_INPUT;
    private int output = DEFAULT_OUTPUT;
    private int preferred = DEFAULT_PREFERRED;
    private int allowed = DEFAULT_ALLOWED;
    private String user = DEFAULT_USER;
    private String pass = DEFAULT_PASS;
    private String host = DEFAULT_HOST;
    private boolean register = DEFAULT_REGISTER;
    private String number = DEFAULT_NUMBER;
    private int port = DEFAULT_PORT;
    private String callerid = DEFAULT_CALLERID;
    private String callernum = DEFAULT_CALLERNUM;
    private URL codeBase;
    
    private ArrayList<String> inputDeviceNames = new ArrayList<String>();
	private ArrayList<String> outputDeviceNames = new ArrayList<String>();
	private int selInput = -1;
	private int selOutput = -1;
	private ArrayList<AudioDevice> inputs;
	private ArrayList<AudioDevice> outputs;

    private JIAXClient iaxc;
    private TextField textField;
    private Listener listener;
    private Button callBtn;
    private Button hangupBtn;
    private Label statusLine;
    private Registration reg;
    private Call incoming;

    static String codeBaseStr = "http://134.117.62.208";

    public static void main (String args[]) {
    	isApplet = false;
    	final IAXTest test = new IAXTest();

    	if (args.length == 2) {
    		test.input = Integer.parseInt(args[0]);
    		test.output = Integer.parseInt(args[1]);
    	}

    	try {
    		test.codeBase = new URL(codeBaseStr);
    	} catch(MalformedURLException e) {
    	}

		test.initProg();
		test.startIaxc();
    }

    public IAXTest() {
    	trace("pre ctor");
    	trace("post ctor");	
    }

    void call(String num)
    {
    	String ext;

    	if (num.indexOf('/') > -1 || num.indexOf('@') > -1) {
    		ext = num;
    	} else {
    		ext = host + ":" + port + "/" + num;
    		String reg = "";
	    
    		if (user.length() != 0) {
    			reg = user;
    			if (pass.length() != 0) {
    				reg = reg + ":" + pass;
    			}
    			ext = reg + "@" + ext;
    		}
    	}

    	final String finExt = ext;

    	try {
            PrivilegedAction action =
                new PrivilegedAction() {
                    public Object run() {
                    	iaxc.call(finExt);
                    	return null;
                    }
                };

            AccessController.doPrivileged(action);
        } catch (AccessControlException e) {
        	showErrorDialog(wnd, e.getLocalizedMessage());
        } catch (UnsatisfiedLinkError e) {
            e.printStackTrace();
        }
    }

    void showErrorDialog(Frame parent, String message)
    {
    	String title = "Error";

    	Panel topPan = new Panel(new GridLayout(0, 1));

    	StringTokenizer st = new StringTokenizer(message, "\n");
    	while (st.hasMoreTokens()) {
    		topPan.add(new Label(st.nextToken()));
    	}


    	Object[] selections = { "Ok" };
    	OptionDialog dlg = new OptionDialog(wnd, title);
		
    	Object sel = dlg.showConfirmDialog(topPan,
					   selections,
					   selections[0]);
    }
    
    //A test method to determince whether communication with javaScript is working
    public String testJS(){
    	return "Hello World";
    }
    
    public void setNumber(String number) {
    	this.number = number;
    	textField.setText(number);
    }
    
    //Added D.Zgon 06/22/07
    public AudioDevice[] getAudioDevices(){
    	return iaxc.getAudioDevices();
    }
    
    //Added D.Zgon 06/22/07
    public void setAudioDevices(int inpos, int outpos){
    	
    	AudioDevice in = (AudioDevice)inputs.get(inpos);
		input = in.getDevID();
		
		AudioDevice out = (AudioDevice)outputs.get(outpos);
		output = out.getDevID();
		
		trace("inpos:" + inpos + " " +
				"input:" + input + " " +
				"outpos:" + outpos + " " +
				"output:" + output);
		
		iaxc.setAudioDevices(in, out, out);
		
    }
    
    //Added D.Zgon 06/22/07
    public void makeAudioString(){
    	AudioDevice[] devices = getAudioDevices();
    	inputs = new ArrayList<AudioDevice>(devices.length);
    	outputs = new ArrayList<AudioDevice>(devices.length);
    	
    	int selInput = -1;
    	int selOutput = -1;
    	
    	for (int i=0; i < devices.length; i++) {
    		AudioDevice device = devices[i];

    		long cap = device.getCapabilities();
    		trace(device.getName() + " " + cap);

    		if ((cap & IAXC_AD_INPUT) != 0) {
    			int pos = inputs.size();

    			if (input == device.getDevID()) {
    				selInput = pos;
    			}

    			inputs.add(device);
    			inputDeviceNames.add(device.getName());
    		}
    		
    		if ((cap & IAXC_AD_OUTPUT) != 0) {
    			int pos = outputs.size();

    			if (output == device.getDevID()) {
    				selOutput = pos;
    			}

    			outputs.add(device);    
    			outputDeviceNames.add(device.getName());
    		}
    	}
    	
    	setInputAudioString(inputDeviceNames);
    	setOutputAudioString(outputDeviceNames);
    	setInputSelection(selInput);
    	setOutputSelection(selOutput);
    	
    }
    
    //Added D.Zgon 06/22
    public void setInputAudioString(ArrayList inputAudio){
    	inputDeviceNames = inputAudio;
    }
    
    //Added D.Zgon 06/22
    public ArrayList<String> getInputAudioString(){
    	return inputDeviceNames;
    }
    
    //Added D.Zgon 06/22
    public void setOutputAudioString(ArrayList outputAudio){
    	outputDeviceNames = outputAudio;
    }
    
    //Added D.Zgon 06/22
    public ArrayList<String> getOutputAudioString(){
    	return outputDeviceNames;
    }
    
    //Added D.Zgon 06/22
    public void setInputSelection(int sel){
    	selInput = sel;
    }
    
    //Added D.Zgon 06/22
    public int getInputSelection(){
    	return selInput;
    }
    
    //Added D.Zgon 06/22
    public void setOutputSelection(int sel){
    	selOutput = sel;
    }
    
    //Added D.Zgon 06/22
    public int getOutputSelection(){
    	return selOutput;
    }
    
    public void showSettingsDialog(Frame parent)
    {
    	String title = "Settings";
    	makeAudioString();

    	Choice inputChooser = new Choice();
    	Choice outputChooser = new Choice();

    	for (int i=0; i < getInputAudioString().size(); i++){
    		inputChooser.add(getInputAudioString().get(i));
    	}
    	
    	for (int i=0; i < getOutputAudioString().size(); i++){
    		outputChooser.add(getOutputAudioString().get(i));
    	}

    	if (getInputSelection() > -1)
    		inputChooser.select(getInputSelection());

    	if (getOutputSelection() > -1)
    		outputChooser.select(getOutputSelection());

    	OptionDialog dlg = new OptionDialog(parent, title);

    	Panel pan = new Panel();
    	GridBagLayout gridbag = new GridBagLayout();
    	GridBagConstraints con = new GridBagConstraints();
    	con.fill = GridBagConstraints.HORIZONTAL;
    	con.weightx = 1;
    	con.weighty = 1;

    	pan.setLayout(gridbag);

    	pan.add(new Label("Input Device:"));
    	pan.add(inputChooser);
    	con.gridwidth = GridBagConstraints.REMAINDER;
    	gridbag.setConstraints(inputChooser, con);

    	pan.add(new Label("Output Device:"));
    	pan.add(outputChooser);
    	con.gridwidth = GridBagConstraints.REMAINDER;
    	gridbag.setConstraints(outputChooser, con);

    	Object[] values = { "Ok", "Cancel" };
    	Object sel = dlg.showConfirmDialog(pan, values, values[0]);

    	if (sel == values[0]) {
    		int inpos = inputChooser.getSelectedIndex();

    		int outpos = outputChooser.getSelectedIndex();

    	}
    }

    String readLicense()
    {
    	URL url;
    	url = getClass().getResource("/COPYING");

    	if (url == null)
    		return null;

    	StringBuffer text = new StringBuffer();

    	try {
    		InputStream in = url.openStream();
    		BufferedReader ir = new BufferedReader(new InputStreamReader(in));
    		while(ir.ready()) {
    			String line = ir.readLine();
    			text.append(line);
    			text.append("\n");
    		}
    	} catch (IOException e) {
    		e.printStackTrace();
    		return null;
    	}

    	return text.toString();
    }

    void showLicenseDialog(Object parent)
    {
    	String title = "JIAXClient license";
    	String license = readLicense();

    	if (license == null)
    		return;

    	TextArea lbl = new TextArea(license);
    	lbl.setEditable(false);

    	Object[] selections = { "Ok" };
    	OptionDialog dlg = new OptionDialog(wnd, title);
		
    	Object sel = dlg.showConfirmDialog(lbl,
					   selections,
					   selections[0]);
    }

    public Component createButtons()
    {
    	String labels[] = {"1","2","3","4","5","6","7","8","9","*","0","#"};
    	ActionListener l = new ActionListener() {
    		public void actionPerformed(ActionEvent e) {
    			String action = e.getActionCommand();

    			iaxc.sendDtmf(action);
    		}
	    };

	    Container c = new Container();
	    c.setLayout(new GridLayout(4,3));

	    for (int i=0; i < labels.length; i++) {
	    	Button b = new Button(labels[i]);
	    	c.add(b);
	    	b.addActionListener(l);
	    }

	    return c;
    }

    // Read string parameter from applet or system property
    public String getStringParameter(String name, String def)
    {
    	String val;

    	if (isApplet)
    		val = getParameter(name);
    	else
    		val = System.getProperty(name);

    	if (val != null) {
    		return val;
    	} else {
    		return def;
    	}
    }

    // Read integer parameter from applet or system property
    public int getIntParameter(String name, int def)
    {
    	int res = def;

    	String val;

    	if (isApplet)
    		val = getParameter(name);
    	else
    		val = System.getProperty(name);
	
    	if (val != null) {
    		try {
    			res = Integer.parseInt(val);
    		} catch (NumberFormatException e) {
    		}
    	}

    	trace("getIntParameter " + name + "=" + val);

    	return res;
    }

    // Read boolean parameter from applet or system property
    public boolean getBoolParameter(String name, boolean def)
    {
    	boolean res = def;
    	String val;

    	if (isApplet)
    		val = getParameter(name);
    	else
    		val = System.getProperty(name);

    	if (val != null) {
    		try {
    			Boolean bool = Boolean.valueOf(val);
    			res = bool.booleanValue();
    			trace("Bool: " + val + "=" + res);
    		} catch (NumberFormatException e) {
    		}
    	}

    	trace("getBoolParameter " + name + "=" + res);

    	return res;
    }

    protected void initProg() {
    	wnd = new Frame("JIAXClient demo app"); 

    	wnd.addWindowListener(new WindowAdapter() {
    		public void windowClosing(WindowEvent e)
    		{
		    
    			shutdownIaxc();
    			System.exit(0);
    		}
	    });
	
    	initIaxc(wnd);

    	wnd.validate();
    	wnd.pack();
    	wnd.setVisible(true);

    	postInitIaxc();
    }

    // Applet methods
    public void init() {
    	codeBase = getCodeBase();
/*    	try {
			codeBase = new URL("http://192.168.0.101/jiaxclient");
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
*/    	
    	wnd = new Frame("JIAXClient demo app"); 
    	initIaxc(this);
    	postInitIaxc();
    }

    public void start() {
    	startIaxc();
    }

    public void stop() {
    	stopIaxc();
    }

    public void destroy() {
    	shutdownIaxc();
    }

    protected void initUI(Container cnt)
    {
    	GridBagLayout gridbag = new GridBagLayout();
    	GridBagConstraints con = new GridBagConstraints();
    	con.fill = GridBagConstraints.HORIZONTAL;
    	con.weightx = 1;
    	con.weighty = 1;

    	cnt.setLayout(gridbag);

    	textField = new TextField(number);
    	textField.addKeyListener(new KeyListener() {
    		public void keyPressed(KeyEvent e)
    		{
    			int code = e.getKeyCode();

    			trace("Pressed: " +
    					code + " " +
    					e.getKeyChar() + " " +
    					e.getKeyText(code));
    		}

    		public void keyReleased(KeyEvent e)
    		{
    		}

    		public void keyTyped(KeyEvent e)
    		{
    			int code = e.getKeyCode();

    			trace("Typed: " +
    					code + " " +
    					e.getKeyChar() + " " +
    					e.getKeyText(code));

    		}
	    });

    	textField.addActionListener(new ActionListener() {
    		public void actionPerformed(ActionEvent event) {
    			String action = event.getActionCommand();
    			call(action);
    		}
	    });

    	con.gridwidth = GridBagConstraints.REMAINDER;
    	gridbag.setConstraints(textField, con);
    	cnt.add(textField);
    	con.gridwidth = 1;

    	ActionListener buttonLst = new ButtonListener();

    	// Answer is wider than Call, replace with Call
    	// after calling pack on the window
    	callBtn = new Button("Answer");
    	callBtn.addActionListener(buttonLst);
    	gridbag.setConstraints(callBtn, con);
    	cnt.add(callBtn);

    	hangupBtn = new Button("Hangup");
    	hangupBtn.addActionListener(buttonLst);
    	hangupBtn.setEnabled(false);
    	cnt.add(hangupBtn);

    	Button settingsBtn = new Button("Settings");
    	settingsBtn.addActionListener(buttonLst);
    	con.gridwidth = GridBagConstraints.REMAINDER;
    	gridbag.setConstraints(settingsBtn, con);
    	cnt.add(settingsBtn);

    	con.gridwidth = 0;

    	Component c1 = createButtons();
    	con.gridwidth = GridBagConstraints.REMAINDER;
    	gridbag.setConstraints(c1, con);
    	cnt.add(c1);

    	statusLine = new Label("Ready");
    	con.gridwidth = GridBagConstraints.REMAINDER;
    	gridbag.setConstraints(statusLine, con);
    	cnt.add(statusLine);

    	cnt.validate();
    }

    private void initIaxc(Container cnt) {
    	input = getIntParameter("INPUT", DEFAULT_INPUT);
    	output = getIntParameter("OUTPUT", DEFAULT_OUTPUT);
    	user = getStringParameter("USER", DEFAULT_USER);
    	pass = getStringParameter("PASS", DEFAULT_PASS);
    	host = getStringParameter("HOST", codeBase.getHost());
    	port = getIntParameter("PORT", DEFAULT_PORT);
    	register = getBoolParameter("REGISTER", DEFAULT_REGISTER);
    	preferred = getIntParameter("PREFERRED", DEFAULT_PREFERRED);
    	allowed = getIntParameter("ALLOWED", DEFAULT_ALLOWED);
    	number = getStringParameter("NUMBER", DEFAULT_NUMBER);
    	callerid = getStringParameter("CALLERID", DEFAULT_CALLERID);
    	callernum = getStringParameter("CALLERNUM", DEFAULT_CALLERNUM);
    	
    	trace("Parameters " + user + ":" + pass + "@" + host);
    	trace("Setting codeBase2: " + codeBase);

    	JIAXClient.setCodeBase(codeBase);

    	try {
    		if (!JIAXClient.checkLibrary()) {
    			JIAXClient.downloadAndInstallLibrary();
    		}
    	} catch(IOException e) {
            e.printStackTrace();
            showErrorDialog(wnd, e.getLocalizedMessage() + "\n" +
			    "Admin privilegies needed to install library?");
            // 	    throw new RuntimeException(e.getLocalizedMessage());
    	}

    	iaxc = JIAXClient.getInstance();

    	initUI(cnt);

    	trace("pre init");
    	if (iaxc.initialize(AUDIO_INTERNAL_PA, 4) < 0) {
    		throw new RuntimeException("Can't initialize IAX Client");
    	}

    	if (register) {
    		trace("register: " + user + "@" + host + ":" + port);
    		reg = iaxc.register(user, pass, host + ":" + port);
    	}
    	iaxc.setCallerID(callerid, callernum);

    	initAudio();

    	listener = new Listener(this, iaxc);
    	iaxc.addIAXListener(listener);
    }

    public void postInitIaxc() {
    	callBtn.setLabel("Call");
    }

    public void startIaxc() {
    	if (running) {
    		trace("Already running");
    		return;
    	}

    	trace("pre start");
    	iaxc.startProcessingThread();
    	trace("post start");

    	running = true;
    }

    public void stopIaxc() {
    	if (!running) {
    		trace("Not running");
    		return;
    	}

    	trace("pre stop");
    	iaxc.stopProcessingThread();
    	trace("post stop");

    	running = false;
    }

    public void shutdownIaxc() {
    	removeAll();
    	iaxc.removeIAXListener(listener);
    	listener = null;

    	stopIaxc();
    	iaxc.dumpAllCalls();
    	trace("pre shutdown");
    	iaxc.shutdown();
    	trace("post shutdown");
    }

    public static void trace(Object str)
    {
    	System.out.println(str);
    }

    public void showStatus(String msg)
    {
    	if (isApplet) {
    		super.showStatus(msg);
    	} else {
    		wnd.setTitle(msg);
    	}
    }

    protected void initAudio() {
    	AudioDevice[] devices = iaxc.getAudioDevices();

    	trace("Found " + devices.length + " devices");
	
    	for (int i=0; i < devices.length; i++) {
    		long cap = devices[i].getCapabilities();
    		trace(devices[i].getName() + " " + cap);

    		if ((input < 0) && (cap & IAXC_AD_INPUT_DEFAULT) != 0) {
    			input = i;
    		}

    		if ((output < 0) && (cap & IAXC_AD_OUTPUT_DEFAULT) != 0) {
    			output = i;
    		}
    	}

    	iaxc.setFormats(preferred, allowed);
    	iaxc.setAudioDevices(devices[input], devices[output], devices[output]);
    	trace("post init");

    	AudioDevice input = iaxc.getAudioInput();
    	trace("input " + input);

    	AudioDevice output = iaxc.getAudioRing();
    	trace("output " + output);

    	AudioDevice ring = iaxc.getAudioRing();
    	trace("ring " + ring);
    }
   
    /**
     * Calls the number passed by the string
     * Added D.Zgonjanin
     * @param number
     */
    public void callNumber(String number) {
    	call(number);
    }
    
    /**
     * Answers the incoming call
     *
     */
    public void answer() {
    	iaxc.answerCall(incoming);
    }
    
    /**
     * Starts Iaxc
     *
     */
    public void startCall() {
    	startIaxc();
    }
    
    /**
     * Stops the current call
     *
     */
    public void stopCall() {
    	stopIaxc();
    }
    
    /**
     * Hangs up (dumps the call)
     *
     */
    public void hangUpCall() {
    	iaxc.dumpCall();
    }
    
    /**
     * Rejects the incoming call
     *
     */
    public void rejectCall() {
    	iaxc.rejectCall(incoming);
    }
    
    /**
     * Shows the settings dialog
     *
     */
    public void showSettings() {
    	//TODO show the settings dialog in JavaScript here
    }

    class ButtonListener implements ActionListener {
    	public void actionPerformed(ActionEvent event) {
    		String action = event.getActionCommand();

    		trace("actionPerformed:" + action);
	    
    		if (action == "Call") {
    			call(textField.getText());
    		} else if (action == "Answer") {
    			iaxc.answerCall(incoming);
    		} else if (action == "Start") {
    			startIaxc();
    		} else if (action == "Stop") {
    			stopIaxc();
    		} else if (action == "Hangup") {
    			iaxc.dumpCall();
    		} else if (action == "Reject") {
    			iaxc.rejectCall(incoming);
    		} else if (action == "Settings") {
    			showSettingsDialog(wnd);
    		}
    	}
    }

    class Listener extends IAXAdapter {
    	private IAXTest parent;
    	private JIAXClient iaxc;
    	private Sound ring;
    	private Sound busySound;

    	Listener(IAXTest parent, JIAXClient iaxc) {
    		this.parent = parent;
    		this.iaxc = iaxc;

    		ring = new Sound();

    		ring.init("425/1000");
    		ring.setRepeat(-1);

    		busySound = new Sound();
    		busySound.init("425/250,0/250");
    		busySound.setRepeat(-1);
    	}

    	public int textReceived(TextEvent e) {
    		String msg = e.getMessage();

    		trace("text: " + msg);

    		if (msg.startsWith("Unknown event:"))
    			return 1;

    		statusLine.setText(msg);
    		return 1;
    	}
    	
    	public int call(CallStateEvent e) {
    		CallState state = e.getState();
    		Call id = e.getCall();
    		String remote = e.getRemote();
    		String local = e.getLocal();
    		String remoteName = e.getRemoteName();
    		String localName = e.getLocalName();
    		CallState oldState = id.getState();

    		CallState added = state.diff(oldState);
    		CallState removed = oldState.diff(state);


    		trace("call:" + id +
    				", " + local +
    				", " + localName +
    				", " + remote +
    				", " + remoteName +
    				" +" + added +
    				" -" + removed +
    				" =" + state);
	    
    		// Don't play ringing tone after the call has been answered
    		if (added.isRinging() && !state.isComplete()) {
    			trace("Ringing");
    			iaxc.playSound(ring, !state.isOutgoing());
    		}

    		if (removed.isRinging()) {
    			trace("Stopped ringing");
    			iaxc.stopSound(ring);
    		}

    		if (added.isBusy()) {
    			trace("Busy");
    			iaxc.playSound(busySound, false);
    		}

    		if (removed.isBusy()) {
    			trace("Stopped busy");
    			iaxc.stopSound(busySound);
    		}

    		if (added.isActive()) {
    			if (state.isOutgoing()) {
    				callBtn.setEnabled(false);
    				hangupBtn.setEnabled(true);
    			} else {
    				incoming = id;
    				callBtn.setEnabled(true);
    				hangupBtn.setEnabled(true);

    				callBtn.setLabel("Answer");
    				hangupBtn.setLabel("Reject");
    			}

    		}

    		if (removed.isActive()) {
    			incoming = null;
    			callBtn.setEnabled(true);
    			hangupBtn.setEnabled(false);

    			callBtn.setLabel("Call");
    			hangupBtn.setLabel("Hangup");
    		}

    		if (added.isComplete()) {
    			if (state.isOutgoing()) {
    				trace("Answered");
    			} else {
    				callBtn.setEnabled(false);
    				hangupBtn.setEnabled(true);
		
    				callBtn.setLabel("Call");
    				hangupBtn.setLabel("Hangup");
    			}
    		}

    		return 1;
    	}

    	public int levelsChanged(LevelsEvent e) {
    		// 	    trace("levels: " + e.getDate() + " " + e.getInput());
    		return 1;
    	}

    	public int netStatsReceived(NetStatsEvent e) {
    		trace("netStatsReceived: "
    				+ e.getCall() + " "
    				+ e.getRtt() + " "
    				+ e.getLocal() + " "
    				+ e.getRemote());
    		return 1;
    	}

    	public int received(UrlEvent event) {
    		trace("received url: "
    				+ event.getCall() + " "
    				+ event.getType() + " "
    				+ event.getUrl());

    		URL url = event.getUrl();

    		if (isApplet) {
    			Object[] selections = { "Ok", "Cancel" };
		
    			OptionDialog dlg = new OptionDialog(wnd,
						    "URL Received");
		
    			Object sel = dlg.showConfirmDialog("Open: " + url + " ?",
						   selections,
						   selections[0]);
		
    			if (sel == "Ok") {
    				trace("Opening: " + url);
		    
    				AppletContext context = getAppletContext();
		    
    				if (context != null) {
    					context.showDocument(url, "_blank");
    				}
    			}
    		}
	    
    		return 1;
    	}

    	public int regAcknowledged(RegistrationEvent e) {
    		trace("regAcknowledged:" + e);

    		//iaxc.unregister(e.getRegistration());
    		return 0;
    	}
	
    	public int regRejected(RegistrationEvent e) {
    		trace("regRejected:" + e);
    		return 0;
    	}
	
    	public int regTimedout(RegistrationEvent e) {
    		trace("regTimedout:" + e);
    		return 0;
    	}
    }
}
