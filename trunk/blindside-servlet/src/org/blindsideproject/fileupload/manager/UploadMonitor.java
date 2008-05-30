package org.blindsideproject.fileupload.manager;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.directwebremoting.*;
import org.directwebremoting.proxy.dwr.Util;
/**
 * 
 * @author ritzalam 
 *
 */
public class UploadMonitor {
	
	
	private static Log log = LogFactory.getLog(UploadMonitor.class);
	private UploadListenerManager uploadListenerManager;
	private UploadListener uploadListener;
		
	public void getUpdate(String roomNo)
	{   
		log.info("Enetering getUpdate...");
		WebContext wctx = WebContextFactory.get();
		Util utilThis = new Util(wctx.getScriptSession());
				
		uploadListener = uploadListenerManager.getListener(roomNo);
		log.info("Initialized uploadListener...");
		
		for(int i = 0; i < uploadListener.getUpdatedMessages().size(); i++)
			{
			if(uploadListener.getUpdatedMessages().isEmpty() == false)
		    utilThis.setValue("response"  , (String) uploadListener.getUpdatedMessages().get(i) );
			}	
		
		log.info("response is being set to the updated messages");
	}
	
    public void setUploadListenerManager(UploadListenerManager uploadListenerManager) {
		this.uploadListenerManager = uploadListenerManager;
	}
	
	

}
