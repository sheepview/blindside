/*
  IAXListener.java
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

public interface IAXListener {
    int textReceived(TextEvent e);
    int call(CallStateEvent e);
    int levelsChanged(LevelsEvent e);
    int netStatsReceived(NetStatsEvent e);

    int received(UrlEvent e);
    int loadingComplete(UrlEvent e);
    int linkRequest(UrlEvent e);
    int linkReject(UrlEvent e);
    int unlink(UrlEvent e);

    int regAcknowledged(RegistrationEvent e);
    int regRejected(RegistrationEvent e);
    int regTimedout(RegistrationEvent e);
}
