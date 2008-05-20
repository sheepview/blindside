package org.blindsideproject.asterisk;

import java.util.Collection;

public interface IConference {
	public void lock();
	public void unlock();
	public void mute();
	public void unmute();
	public boolean isMuted();
	public boolean isLocked();
	public Collection<IParticipant> getParticipants();
}
