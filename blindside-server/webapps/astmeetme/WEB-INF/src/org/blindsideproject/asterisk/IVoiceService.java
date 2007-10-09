package org.blindsideproject.asterisk;

import java.util.Collection;

import org.asteriskjava.live.AsteriskServerListener;
import org.asteriskjava.live.ManagerCommunicationException;
import org.asteriskjava.live.MeetMeUser;

public interface IVoiceService {
	public void start();
	public void stop();
	public IConference getConference(String id);
	public Collection<MeetMeUser> getUsers(String roomId);
	
	public void addAsteriskServerListener(AsteriskServerListener listener) throws ManagerCommunicationException;
	
}