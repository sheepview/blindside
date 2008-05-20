package org.blindsideproject.presentation;

import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.Message;

import org.apache.activemq.command.ActiveMQQueue;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.jms.core.JmsTemplate;

public class ConversionUpdatesService implements IConversionUpdatesService {
	protected static Logger logger = LoggerFactory.getLogger(ConversionUpdatesService.class);

    private JmsTemplate template = null;
    private Destination destination = null;
    private volatile Thread updatesListenerThread;
    
    private boolean waitForMessage = true;
	
    private ConversionUpdatesListener updatesListener;
    
	public void start() {
		
		ConversionUpdatesListenerThread listener = new ConversionUpdatesListenerThread();
		
		updatesListenerThread = new Thread(listener, "Conversion Updates Listener");
		updatesListenerThread.start();
	}

	public void stop() {
		waitForMessage = false;
	}

	public void setDestination(ActiveMQQueue destination) {
		this.destination = (Destination) destination;
	}

	public void setJmsTemplate(JmsTemplate jmsTemplate) {
		this.template = jmsTemplate;
	}
	
	private class ConversionUpdatesListenerThread implements Runnable
	{

		public void run() {
	        logger.info("Will wait for document conversion updates messages.");
	        
	        while (waitForMessage) {
	        	Message msg = template.receive(destination);
	        	
	        	int room;
				try {
					room = msg.getIntProperty("room");
					int code = msg.getIntProperty("returnCode");
					
					if (msg.propertyExists("message")) {
						String message = msg.getStringProperty("message");
						updatesListener.updateMessage(room, code, message);
					} else if (msg.propertyExists("totalSlides")) {
						int totalSlides = msg.getIntProperty("totalSlides");
						int completedSlides = msg.getIntProperty("slidesCompleted");
						updatesListener.updateMessage(room, code, totalSlides, completedSlides);
					} else {
						logger.error("Cannot handle recieved message.");
					}
//		        	System.out.println("Room = [" + room + "," + code + "]");
//		        	System.out.println("Message=[" + message + "]");
		        	
				} catch (JMSException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        }
		}
		
	}

	public void setUpdatesListener(ConversionUpdatesListener updatesListener) {
		this.updatesListener = updatesListener;
	}
}
