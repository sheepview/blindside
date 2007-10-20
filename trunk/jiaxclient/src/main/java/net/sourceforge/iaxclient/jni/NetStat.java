/*
  NetStat.java
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

public class NetStat {
    private int jitter;
    private int losspct;
    private int losscnt;
    private int packets;
    private int delay;
    private int dropped;
    private int ooo;
    
    public NetStat(int jitter, int losspct, int losscnt, int packets,
		   int delay, int dropped, int ooo)
    {
	this.jitter = jitter;
	this.losspct = losspct;
	this.losscnt = losscnt;
	this.packets = packets;
	this.delay = delay;
	this.dropped = dropped;
	this.ooo = ooo;
    }

    public int getJitter() { return jitter; }
    public int getLosspct() { return losspct; }
    public int getLosscnt() { return losscnt; }
    public int getPackets() { return packets; }
    public int getDelay() { return delay; }
    public int getDropped() { return dropped; }
    public int getOoo() { return ooo; }

    public String toString() {
	return "[" + jitter + " " + losspct + " " + losscnt + " "
	    + packets + " " + delay + " " + dropped + " " + ooo + "]";
    }
}
