package org.blindsideproject.fileupload.document.impl;

import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.Session;

import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.core.MessageCreator;
/**
 * 
 * @author ritzalam 
 *
 */
public class UpdatesMessageSender {
    private JmsTemplate template = null;
    private Destination destination = null;
    
    
	public void setJmsTemplate(JmsTemplate template) {
		this.template = template;
	}

	public void setDestination(Destination destination) {
		this.destination = destination;
	}
	
	public void sendMessage(final Integer room, final ReturnCode code, final String message) {
        template.send(destination, new MessageCreator() {
            public Message createMessage(Session session) throws JMSException {
            	Message msgToSend = session.createTextMessage(message);
            	msgToSend.setIntProperty("room", room);
            	msgToSend.setIntProperty("returnCode", code.value());
            	msgToSend.setStringProperty("message", message);
                return msgToSend;
            }
        });
	}

	public void sendMessage(final Integer room, final ReturnCode code, final int totalNumSlides, final int curNumSlide) {
        template.send(destination, new MessageCreator() {
            public Message createMessage(Session session) throws JMSException {
            	Message msgToSend = session.createTextMessage("Progress update");
            	msgToSend.setIntProperty("room", room);
            	msgToSend.setIntProperty("returnCode", code.value());
            	msgToSend.setIntProperty("totalSlides", totalNumSlides);
            	msgToSend.setIntProperty("slidesCompleted", curNumSlide);
            	
                return msgToSend;
            }
        });
	}
}
