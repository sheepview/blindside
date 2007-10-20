/*
  TextEvent.java
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

import net.sourceforge.iaxclient.jni.IAXEvent;
import net.sourceforge.iaxclient.jni.LibJiaxc;

public class TextEvent extends IAXEvent {
    private int type;
    private Call call;
    private String message;
    
    TextEvent(LibJiaxc obj, long date, int type, Call call, String message) {
	super(obj, date);

	this.type = type;
	this.call = call;
	this.message = message;
    }
    	
    public int getType() { return type; }
    public Call getCall() { return call; }
    public String getMessage() { return message; }
}
