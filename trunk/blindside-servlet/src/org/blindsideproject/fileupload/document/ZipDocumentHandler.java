package org.blindsideproject.fileupload.document;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


public class ZipDocumentHandler {
    private static Log log = LogFactory.getLog(ZipDocumentHandler.class);
    
    private void copyInputStream(InputStream in, OutputStream out)
    throws IOException {
    	byte[] buffer = new byte[1024];
    	int len;

    	while ((len = in.read(buffer)) >= 0) {
    		out.write(buffer, 0, len);
    	}

    	in.close();
    	out.close();
    }

    public void convert(File fileInput, File destDir) {
    	try {
    		// Setup the zipfile used to read entries
    		ZipFile zf = new ZipFile(fileInput.getAbsolutePath());
    		
            // Ensure the extraction directories exist
//            File directoryStructure = new File(destDir);
            if (!destDir.exists()) {
            	destDir.mkdirs();
            }
            
    		// Loop through all entries in the zip and extract as necessary
    		ZipEntry currentEntry;
    		for (Enumeration entries = zf.entries(); entries.hasMoreElements();) {
    			currentEntry = (ZipEntry) entries.nextElement();
    			
    			if (!currentEntry.isDirectory()) {
    				File fileEntry = new File(currentEntry.getName());
    				String fileName = fileEntry.getName().toLowerCase();
    				// Make sure to only deal with image files
    				if ((fileName.endsWith(".jpg")) ||
    					(fileName.endsWith(".png")) ||
    					(fileName.endsWith(".gif"))) {
    						copyInputStream(zf.getInputStream(currentEntry),
    								new BufferedOutputStream(new FileOutputStream(destDir 
    										+ File.separator + fileEntry.getName())));
    					}
    			}
    		}
        } catch (Exception e) {
            if (log.isErrorEnabled()) {
                log.error("Could not load zip document for " +
                          fileInput.getName(), e);
            }
        }
    }
}
