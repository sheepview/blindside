package org.bigbluebuttonproject.fileupload.document;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


/**
 * This class is used for logging in blindside-servlet. Provides a compact way for other classes to log. 
 * 
 * @author ritzalam 
 *
 */
public class LogProgressListener implements IProgressListener {
	private static Log log = LogFactory.getLog(LogProgressListener.class);
	
	public void update(String message) {
		log.info(message);
	}

}
