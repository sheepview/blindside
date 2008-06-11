package org.bigbluebuttonproject.fileupload.manager;

import java.util.HashMap;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
/**
 * 
 * @author ritzalam 
 *
 */
public class UploadListenerManager  {
	
	private static Log log = LogFactory.getLog(UploadListenerManager.class);
	private String roomNo;
	private UploadListener uploadListener;
	private Map <String, UploadListener> rooms = new HashMap<String, UploadListener>();
    
	public UploadListener getListener (String roomNo)
    {
		log.info("getting upload listener..");
		return rooms.get(roomNo);
    }
	
    public void addListener(String roomNo , UploadListener uploadListener)
    {
    	log.info("adding upload listener to UploadListenerManager...");
    	this.uploadListener = uploadListener;
    	this.roomNo = roomNo;
    	rooms.put(roomNo, this.uploadListener);
    }
   
    public UploadListener createUploadListener(String roomNo)
    {
    	uploadListener = new UploadListener(roomNo);
    	log.info("creating upload listener..");
    	return uploadListener;
    }
    
}
