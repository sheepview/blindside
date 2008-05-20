package org.blindsideproject.presentation.bootstrap;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.blindsideproject.presentation.IConversionUpdatesService;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class JmsConnectionContextListener implements ServletContextListener {
	protected static Logger logger = LoggerFactory.getLogger(JmsConnectionContextListener.class);
	
	public void contextInitialized(ServletContextEvent event) {
		
		WebApplicationContext ctx = 
			WebApplicationContextUtils.getRequiredWebApplicationContext(
				event.getServletContext());

		IConversionUpdatesService service = (IConversionUpdatesService) ctx.getBean("presentationService");
		logger.info("Connecting to presentation service");
		service.start();
		logger.info("Connected to presentation service");
	}
	
	public void contextDestroyed(ServletContextEvent event) {
		WebApplicationContext ctx = 
			WebApplicationContextUtils.getRequiredWebApplicationContext(
				event.getServletContext());

		IConversionUpdatesService service = (IConversionUpdatesService) ctx.getBean("presentationService");
		logger.info("Disconnecting from presentation service");
		service.stop();
		logger.info("Disconnected to presentation service");
	
	}



}
