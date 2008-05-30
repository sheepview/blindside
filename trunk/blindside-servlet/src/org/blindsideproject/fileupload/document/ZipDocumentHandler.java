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


/**
 * This class is used to extract uploaded slides in zip format. Zip file can only contain file formats: JPG, PNG or GIF.
 * Other formats in zip file are ignored (not extracted).
 * 
 * @author ritzalam 
 *
 */
public class ZipDocumentHandler {
	
	// logging error when extracting (during exception)
    private static Log log = LogFactory.getLog(ZipDocumentHandler.class);
    
    
    /**
     * This method is called from convert(File fileInput, File destDir), 
     * to write the contents of InputStream given to OutputStream given.
     * This is needed when extracting files from a zip file. 
     * 
     * @param in 
     * @param out OutputStream pointing to output file
     * @throws IOException
     */
    private void copyInputStream(InputStream in, OutputStream out)
    throws IOException {
    	byte[] buffer = new byte[1024];
    	int len;
    	// copying contents from in to out
    	while ((len = in.read(buffer)) >= 0) {
    		out.write(buffer, 0, len);
    	}

    	in.close();
    	out.close();
    }

    /**
     * This method extracts the zip file given to the destDir. It uses ZipFile API 
     * to parse through the files in the zip file.
     * Only files that the zip file can have are .jpg, .png and .gif formats.
     * 
     * @param fileInput pointing to the zip file
     * @param destDir directory where extracted files should go
     */
    public void convert(File fileInput, File destDir) {
    	try {
    		// Setup the ZipFile used to read entries
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
    						// extracts the corresponding file in dest Directory
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
