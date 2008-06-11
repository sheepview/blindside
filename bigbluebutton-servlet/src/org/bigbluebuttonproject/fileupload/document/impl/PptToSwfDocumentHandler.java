package org.bigbluebuttonproject.fileupload.document.impl;
import java.io.File;
import java.net.ConnectException;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.artofsolving.jodconverter.DocumentConverter;
import com.artofsolving.jodconverter.openoffice.connection.OpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;

public class PptToSwfDocumentHandler {
	private static final Log logger = LogFactory.getLog(PptToSwfDocumentHandler.class);
	
	private String openOfficeHost = "localhost";
	private int openOfficePort = 8100;
	private UpdatesMessageSender updatesMsgSender = null;

	private String swftoolConverter;
	
    public void setUpdatesMsgSender(UpdatesMessageSender updatesMsgSender) {
		this.updatesMsgSender = updatesMsgSender;
	}

	public void setOpenOfficeHost(String host) {
    	this.openOfficeHost = host;
    }
    
    public void setOpenOfficePort(int port) {
    	this.openOfficePort = port;
    }
    
    public synchronized void convert(Integer room, File fileSource, File destDir) {

        OpenOfficeConnection connection = new SocketOpenOfficeConnection(openOfficeHost, openOfficePort);
        try {
            logger.info("-- connecting to OpenOffice.org on port " + openOfficePort);
            updatesMsgSender.sendMessage(room, ReturnCode.UPDATE, "Connecting to OpenOffice server.");
            connection.connect();
        } catch (ConnectException officeNotRunning) {
            logger.error("ERROR: connection failed. Please make sure OpenOffice is running and listening on port "
                            + openOfficePort + ".");
            updatesMsgSender.sendMessage(room, ReturnCode.OO_CONNECTION, "Cannot connect to OpenOffice.");
        }
        try {
        	updatesMsgSender.sendMessage(room, ReturnCode.UPDATE, "Successfully connected to OpenOffice server.");
            DocumentConverter converter = new PptToSwfConverter(updatesMsgSender, room, connection);
            File outputFile = new File(destDir.getAbsolutePath() + File.separator + "output.pdf");
            
            // Set the tool to be used to convert from PDF to SWF.
            ((PptToSwfConverter)converter).setSwftoolConverter(swftoolConverter);
            // Start converting the document
            converter.convert(fileSource, outputFile);
        } finally {
            logger.info("-- disconnecting");
            connection.disconnect();
        }
    }

	public void setSwftoolConverter(String swftoolConverter) {
		this.swftoolConverter = swftoolConverter;
	}
}

