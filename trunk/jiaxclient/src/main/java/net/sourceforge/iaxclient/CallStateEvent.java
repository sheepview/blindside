/*
  CallStateEvent.java
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

import net.sourceforge.iaxclient.jni.LibJiaxc;
import net.sourceforge.iaxclient.jni.IAXEvent;

public class CallStateEvent extends IAXEvent {
    private Call call;
    private CallState state;
    private String remote;
    private String remoteName;
    private String local;
    private String localName;
    
    CallStateEvent(LibJiaxc obj, long date, Call call, CallState state,
		   String remote, String remoteName,
		   String local, String localName) {
	super(obj, date);

	this.call = call;
	this.state = state;
	this.remote = remote;
	this.remoteName = remoteName;
	this.local = local;
	this.localName = localName;
    }
    
    public Call getCall() { return call; }
    public CallState getState() { return state; }
    public String getRemote() { return remote; }
    public String getRemoteName() { return remoteName; }
    public String getLocal() { return local; }
    public String getLocalName() { return localName; }
}
