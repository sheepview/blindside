package org.blindsideproject.presentation;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.red5.server.api.so.ISharedObject;

public class ConversionUpdatesListener {
	protected static Logger log = LoggerFactory.getLogger(ConversionUpdatesListener.class);
	
	private static Map<Integer, ISharedObject> presentationSOs = new HashMap<Integer, ISharedObject>();

    public void addRoom(Integer room, ISharedObject so) {
    	presentationSOs.put(room, so);
    }

    public void updateMessage(Integer room, Integer code, String message) {
    	if (! presentationSOs.containsKey(room)) {
    		log.info("Getting updates message from unknown room [" + room + "]");
    		return;
    	}
    	
    	ISharedObject so = presentationSOs.get(room);
    	Map <String, Object> update = new HashMap<String, Object>();
    	so.beginUpdate();
    	
    	if (code == ReturnCode.SUCCESS.value()) {
    		update.put("returnCode", "SUCCESS");
        	update.put("message", message);
    	} else if (code == ReturnCode.UPDATE.value()) {
    		update.put("returnCode", "UPDATE");
        	update.put("message", message);    		
    	} else {
    		update.put("returnCode", "FAILED");
        	update.put("message", message);
    	}
    	so.setAttribute("updateMessage", update);
    	so.endUpdate();
    }
    
    public void updateMessage(Integer room, Integer code, Integer totalSlides, Integer completedSlides) {
    	if (! presentationSOs.containsKey(room)) {
    		log.info("Getting updates message from unknown room [" + room + "]");
    		return;
    	}
    	
    	ISharedObject so = presentationSOs.get(room);
    	Map <String, Object> update = new HashMap<String, Object>();
    	so.beginUpdate();
    	if (code == ReturnCode.EXTRACT.value()) {
    		update.put("returnCode", "EXTRACT");
    		update.put("totalSlides", totalSlides);
    		update.put("completedSlides", completedSlides);
    	} else if (code == ReturnCode.CONVERT.value()) {   		
    		update.put("returnCode", "CONVERT");
    		update.put("totalSlides", totalSlides);
    		update.put("completedSlides", completedSlides);
    	}
    	
    	so.setAttribute("updateMessage", update);
    	so.endUpdate();
    }    
}
