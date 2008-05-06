package org.blindsideproject.asterisk;

import java.beans.PropertyChangeListener;
import java.util.Date;

public interface IParticipant {
    boolean isTalking();

    boolean isMuted();
    
    Date getDateJoined();

    Date getDateLeft();
    
    IConference getConference();

    Integer getParticipantId();
    
    String getCallerIdName();
    
    String getCallerIdNumber();

    void mute();

    void unmute();

    void kick();	
    
    void addPropertyChangeListener(PropertyChangeListener listener);
    
}
