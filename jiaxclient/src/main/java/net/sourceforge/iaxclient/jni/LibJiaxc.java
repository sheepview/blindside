/*
  LibJiaxc.java
  Copyright (C) 2004-2005  Mikael Magnusson <mikma@users.sourceforge.net>

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.
  
  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.
  
  You should have received a copy of the GNU Lesser General Public
  License along with this library; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307  USA
*/

package net.sourceforge.iaxclient.jni;

public abstract class LibJiaxc implements Constants {
    protected native int initialize(int audType, int nCalls);
    public native void shutdown();
    public native void setFormats(int preferred, int allowed);
    public native void setMinOutgoingFramesize(int samples);
    public native void setCallerID(String name, String number);
    public native void processCalls();
    protected native int startProcessingThread();
    protected native int stopProcessingThread();
    public native void call(String num);
    protected native int unregisterId(int id);
    protected native int registerId(String user, String pass, String host);
    protected native void answerCall(int callNo);
    protected native void blindTransferCall(int callNo, String number);
    public native void dumpAllCalls();
    public native void dumpCall();
    public native void rejectCall();
    protected native void rejectCallNumber(int callNo);
    public native void sendDtmf(char digit);
    public native void sendText(String text);
    /* sendUrl: link ? AST_HTML_LINKURL : AST_HTML_URL */
    protected native void sendUrlStr(String url, boolean link);
    public native void milliSleep(long ms);
    public native void setSilenceThreshold(double thr);
    public native void setAudioOutput(int mode);

    protected native void selectCall(int callNo)
	throws IndexOutOfBoundsException;
    protected native int firstFreeCallNo();
    protected native int selectedCallNo();
    protected native void quelch(int callNo, int MOH)
	throws IndexOutOfBoundsException;
    protected native void unquelch(int callNo)
	throws IndexOutOfBoundsException;

    public native int getMicBoost();
    public native int setMicBoost(boolean enable);

    public static native String getVersion();

    public native AudioDevice[] getAudioDevices();
    protected native int getAudioInputDevice();
    protected native int getAudioOutputDevice();
    protected native int getAudioRingDevice();
    protected native void setAudioDevices(int input, int output, int ring)
	throws IllegalArgumentException;
    public native double getInputLevel();
    public native double getOutputLevel();
    public native int setInputLevel(double level);
    public native int setOutputLevel(double level);

    protected native int playSound(short[] data, int repeat, boolean ring);
    protected native void stopSound(int id) throws IllegalArgumentException;

    public native int getFilters();
    public native void setFilters(int filters);
    protected native int setFiles(String input, String output);

    public native IAXEvent getNextEvent() throws InterruptedException;

    abstract protected IAXEvent
	createCallStateEvent(long date, int callNo, int state,
			     String remove, String removeName,
			     String local, String localName);

    abstract protected IAXEvent
	createTextEvent(long date, int type, int callNo, String message);

    abstract protected IAXEvent
	createLevelsEvent(long date, float input, float output);

    abstract protected IAXEvent
	createUrlEvent(long date, int type, int callNo, String url);

    abstract protected IAXEvent
	createRegistrationEvent(long date, int id, int reply, int msgcount);

    abstract protected AudioDevice
	createAudioDevice(String name, long capabilities, int devID);

    abstract protected NetStat
	createNetStat(int jitter, int losspct, int losscnt, int packets,
		      int delay, int dropped, int ooo);

    abstract protected IAXEvent
	createNetStatsEvent(long date, int callNo, int rtt,
			    NetStat local, NetStat remote);

}
