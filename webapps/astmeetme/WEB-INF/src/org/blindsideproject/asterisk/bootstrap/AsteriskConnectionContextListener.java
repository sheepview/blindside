package org.blindsideproject.asterisk.bootstrap;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import org.blindsideproject.asterisk.IVoiceService;

public class AsteriskConnectionContextListener implements ServletContextListener {
	private final Log logger = LogFactory.getLog(getClass());
	
	public void contextInitialized(ServletContextEvent event) {
		
		WebApplicationContext ctx = 
			WebApplicationContextUtils.getRequiredWebApplicationContext(
				event.getServletContext());

		IVoiceService service = (IVoiceService) ctx.getBean("voiceService");
		logger.info("Logging into Asterisk server.");
		service.start();
		logger.info("Logged in from Asterisk server.");
	}
	
	public void contextDestroyed(ServletContextEvent event) {
		WebApplicationContext ctx = 
			WebApplicationContextUtils.getRequiredWebApplicationContext(
				event.getServletContext());

		IVoiceService service = (IVoiceService) ctx.getBean("voiceService");
		logger.info("Logging out from Asterisk server.");
		service.stop();
		logger.info("Logged out from Asterisk server.");
	
	}



}
