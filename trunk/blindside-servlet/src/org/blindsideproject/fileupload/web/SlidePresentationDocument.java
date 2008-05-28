package org.blindsideproject.fileupload.web;

import org.blindsideproject.fileupload.document.UnsupportedPresentationDocumentException;
import org.blindsideproject.fileupload.document.ZipDocumentHandler;
import org.blindsideproject.fileupload.document.impl.FileSystemSlideManager;
import org.blindsideproject.fileupload.document.impl.PdfToSwfDocumentHandler;
import org.blindsideproject.fileupload.document.impl.PptDocumentHandler;
import org.blindsideproject.fileupload.document.impl.PptToSwfDocumentHandler;
import org.blindsideproject.fileupload.document.impl.ReturnCode;
import org.blindsideproject.fileupload.document.impl.UpdatesMessageSender;
import org.blindsideproject.fileupload.manager.UploadListener;
import org.blindsideproject.fileupload.manager.UploadListenerManager;
import org.blindsideproject.fileupload.manager.UploadMonitor;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.core.MessageCreator;

import com.artofsolving.jodconverter.openoffice.connection.OpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;

import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.Session;

/**
 * This class is used to 
 * 
 * @author kthiruka
 *
 */


public class SlidePresentationDocument {
    private static Log log = LogFactory.getLog(SlidePresentationDocument.class);

    private FileSystemSlideManager slideManager = null;
    private PptDocumentHandler pptDocumentHandler = null;
    private ZipDocumentHandler zipDocumentHandler = null;
    private PptToSwfDocumentHandler pptToSwfHandler = null;
    private PdfToSwfDocumentHandler pdfToSwfHandler = null;
    
   
    private File uploadedFile = null;
    // directory of the file to be uploaded to memory from file System
    private File destDir = null;
    private Integer room;
    
    private UpdatesMessageSender updatesMsgSender = null;
	
    public void load(File uploaded, Integer room) 
		throws UnsupportedPresentationDocumentException
	{
        if ((uploaded.getName().toLowerCase().endsWith(".pdf")) ||
            (uploaded.getName().toLowerCase().endsWith(".ppt")))
        {            
            this.uploadedFile = uploaded;
            this.room = room;
            
			destDir = new File(slideManager.getBaseDirectory() + File.separator 
					+ room + File.separator + slideManager.getExtractedFolder());

			// Clean the directory of remnant files.
			if (destDir.exists()) {
				log.info("Directroy not empty = [" + destDir.getAbsolutePath() + "]- deleting");
				
				/** This delete seems not to work. **/
				// destDir.delete();
				// Let's just loop through the file and delete one-by-one
				File[] files = destDir.listFiles();				
				for (int i = 0; i < files.length; i++) {
					files[i].delete();
				}
			
			} else {	            
				// Create a clean directory
				destDir.mkdirs();				
			}	
     
            log.info("Loading file from [" + uploadedFile.getName() + "]");
          
            DocumentLoader loader = new DocumentLoader();
            Thread docLoader = new Thread(loader, "Document Loader");
            docLoader.start();
        } else {
        	updatesMsgSender.sendMessage(room, ReturnCode.WRONG_FORMAT, "Unsupported file type.");
        	
        	throw new UnsupportedPresentationDocumentException("Unsupported file type.");
        }
	}
	
	public void setSlideManager(FileSystemSlideManager slideManager) {
		this.slideManager = slideManager;
	}

	public void setPptDocumentHandler(PptDocumentHandler pptDocumentHandler) {
		this.pptDocumentHandler = pptDocumentHandler;
	}

	public void setZipDocumentHandler(ZipDocumentHandler zipDocumentHandler) {
		this.zipDocumentHandler = zipDocumentHandler;
	}
	
    /**
     * Internal class used to perform the background loading of a zip slide
     * presentation
     */
    private class DocumentLoader implements Runnable {

        public void run() {

            try {
            	
                if (uploadedFile.getName().toLowerCase().endsWith(".pdf")) {
                	pdfToSwfHandler.convert(room, uploadedFile, destDir);                    
                } else if (uploadedFile.getName().toLowerCase().endsWith(".ppt")) {
                	updatesMsgSender.sendMessage(room, ReturnCode.UPDATE, "Converting Powerpoint document.");
//                	if (pptDocumentHandler == null)
//                		log.error("PPTHandler == NULL!!!!");
//                	pptDocumentHandler.convert(uploadedFile, destDir);

                	pptToSwfHandler.convert(room, uploadedFile, destDir);                	
                } else {
                    log.error("Unsupported File.");
                    updatesMsgSender.sendMessage(room, ReturnCode.WRONG_FORMAT, "Unsupported file type.");
                    return;
                }

                ArrayList<File> generatedFiles = new ArrayList<File>(0);
                log.info("Loading slides from '" + destDir + "'.");
                
                generatedFiles = slideManager.getExtractedSlides(destDir.getAbsolutePath());
                             
                // Update the user if no slides were generated (which is unlikely)
                if (generatedFiles.size() < 1) {
                    if (log.isErrorEnabled()) {
                        log.error("Failed to generate slides.");
                    }
                    
                    return;
                }
        
                File currentFile;
/***
 * Don't do this for now. Need to get slides as quickly as possible.
 * Let's do this when we can provide feedback to user through DWR.
                // Create thumnails
                String thumbName = "thumb-";
                
                for (int i = 0; i < generatedFiles.size(); i++) {
                    currentFile = (File) generatedFiles.get(i);
                    String filePath = currentFile.getParent();
                    String fileName = currentFile.getName();
                    
                    File thumbNail = new File(filePath + File.separator + thumbName + fileName);
                    
            		try {
            			slideManager.resizeImage(currentFile, thumbNail, 1.0f, 150);
            			log.info("Creating thumbnail '" + currentFile + "'.");
            			
            		} catch (Exception e) {
                        if (log.isErrorEnabled()) {
                            log.error("Failed to create icon " + currentFile.getName());
                        }           			
            		}
                }                
*/                
/*                // Now resize the slides
                for (int i = 0; i < generatedFiles.size(); i++) {
                    currentFile = (File) generatedFiles.get(i);
            		try {
            			slideManager.resizeImage(currentFile, currentFile, 1.0f, 400);
            			log.info("Resizing image '" + currentFile + "'.");
            			
            		} catch (Exception e) {
                        if (log.isErrorEnabled()) {
                            log.error("Failed to resize image " + currentFile.getName());
                        }           			
            		}
                }
*/                    
                String slidesXml = slideManager.createXml(room);
                updatesMsgSender.sendMessage(room, ReturnCode.SUCCESS, slidesXml);                
            
            } catch (Exception e) {
                if (log.isErrorEnabled()) {
                    log.error("Could not load document: \n ");
                    e.printStackTrace();
                }
            }
        }        
    }

	public void setPptToSwfHandler(PptToSwfDocumentHandler pptToSwfHandler) {
		this.pptToSwfHandler = pptToSwfHandler;
	}

	public void setPdfToSwfHandler(PdfToSwfDocumentHandler pdfToSwfHandler) {
		this.pdfToSwfHandler = pdfToSwfHandler;
	}	
	
	public void setUpdatesMsgSender(UpdatesMessageSender updatesMsgSender) {
		this.updatesMsgSender = updatesMsgSender;
	}	
}