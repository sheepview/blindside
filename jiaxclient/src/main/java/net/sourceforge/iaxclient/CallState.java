/*
  CallState.java
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

import net.sourceforge.iaxclient.jni.Constants;

public class CallState implements Constants
{
    private int state;
    private String[] labels = { "free", "active", "outgoing",
				"ringing", "complete", "selected",
				"busy", "transfer"};

    public boolean isFree() { return isFlagOn(CALL_STATE_FREE); }
    public boolean isActive() { return isFlagOn(CALL_STATE_ACTIVE); }
    public boolean isOutgoing() { return isFlagOn(CALL_STATE_OUTGOING); }
    public boolean isRinging() { return isFlagOn(CALL_STATE_RINGING); }

    // Call answered
    public boolean isComplete() { return isFlagOn(CALL_STATE_COMPLETE); }
    public boolean isSelected() { return isFlagOn(CALL_STATE_SELECTED); }
    public boolean isBusy() { return isFlagOn(CALL_STATE_BUSY); }
    public boolean isTransfer() { return isFlagOn(CALL_STATE_TRANSFER); }

    public CallState diff(CallState s2) {
	int state2 = state & ~s2.state;
	return new CallState(state2);
    }

    public String toString() {
	String str = "";

	for (int i = 0; i < labels.length; i++) {
	    if ((state & (1 << i)) != 0) {
		str += " " + labels[i];
	    }
	}
	
	return str;
    }

    CallState() {
	this(0);
    }

    CallState(int state) {
	this.state = state;
    }

    protected boolean isFlagOn(int flag) {
	return (state & flag) != 0;
    }
}
