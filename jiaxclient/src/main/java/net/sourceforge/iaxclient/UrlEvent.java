/*
  UrlEvent.java
  Copyright (C) 2005  Mikael Magnusson <mikma@users.sourceforge.net>
  
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
import java.net.URL;

public class UrlEvent extends IAXEvent {
    private int type;
    private Call call;
    private URL url;
    
    UrlEvent(LibJiaxc obj, long date, int type, Call call, URL url) {
	super(obj, date);

	this.type = type;
	this.call = call;
	this.url = url;
    }
    	
    public int getType() { return type; }
    public Call getCall() { return call; }
    public URL getUrl() { return url; }
}
