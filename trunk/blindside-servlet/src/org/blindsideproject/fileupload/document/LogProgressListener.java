package org.blindsideproject.fileupload.document;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class LogProgressListener implements IProgressListener {
	private static Log log = LogFactory.getLog(LogProgressListener.class);
	
	public void update(String message) {
		log.info(message);
	}

}
