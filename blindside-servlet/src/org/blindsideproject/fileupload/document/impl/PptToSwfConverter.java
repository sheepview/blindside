package org.blindsideproject.fileupload.document.impl;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.artofsolving.jodconverter.DocumentFormat;
import com.artofsolving.jodconverter.openoffice.connection.OpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.connection.OpenOfficeException;
import com.artofsolving.jodconverter.openoffice.converter.AbstractOpenOfficeDocumentConverter;
import com.sun.star.drawing.XDrawPage;
import com.sun.star.frame.XComponentLoader;
import com.sun.star.frame.XStorable;
import com.sun.star.lang.IndexOutOfBoundsException;
import com.sun.star.lang.WrappedTargetException;
import com.sun.star.lang.XComponent;
import com.sun.star.ucb.XFileIdentifierConverter;
import com.sun.star.uno.Exception;
import com.sun.star.uno.UnoRuntime;

/**
 * This class converts a PowerPoint document to PDFs then to SWFs.
 *
 */
public class PptToSwfConverter extends AbstractOpenOfficeDocumentConverter {
	private static final Log logger = LogFactory.getLog(PptToSwfConverter.class);
	
	private UpdatesMessageSender updatesMsgSender = null;	
	private Integer room;
	private String swftoolConverter;
	private int totalNumPages = 0;
	
	public PptToSwfConverter(UpdatesMessageSender updatesMsgSender, Integer room, OpenOfficeConnection connection) {
		super(connection);
		this.room = room;
		this.updatesMsgSender = updatesMsgSender;
	}

	/**
	 * Implementation the same as OpenOfficeDocumentConverter
	 */
	protected void convertInternal(InputStream inputStream, DocumentFormat inputFormat, OutputStream outputStream, DocumentFormat outputFormat) {
		File inputFile = null;
		File outputFile = null;
		try {
			inputFile = File.createTempFile("document", "." + inputFormat.getFileExtension());
			OutputStream inputFileStream = null;
			try {
				inputFileStream = new FileOutputStream(inputFile);
				IOUtils.copy(inputStream, inputFileStream);
			} finally {
				IOUtils.closeQuietly(inputFileStream);
			}
			
			outputFile = File.createTempFile("document", "." + outputFormat.getFileExtension());
			convert(inputFile, inputFormat, outputFile, outputFormat);
			InputStream outputFileStream = null;
			try {
				outputFileStream = new FileInputStream(outputFile);
				IOUtils.copy(outputFileStream, outputStream);
			} finally {
				IOUtils.closeQuietly(outputFileStream);
			}
		} catch (IOException ioException) {
			throw new OpenOfficeException("conversion failed", ioException);
		} finally {
			if (inputFile != null) {
				inputFile.delete();
			}
			if (outputFile != null) {
				outputFile.delete();
			}
		}
	}

	protected void convertInternal(File inputFile, DocumentFormat inputFormat, File outputFile, DocumentFormat outputFormat) {
        Map<String,Object> loadProperties = new HashMap<String,Object>();
        loadProperties.putAll(getDefaultLoadProperties());
        loadProperties.putAll(inputFormat.getImportOptions());

        Map<String,Object> storeProperties = outputFormat.getExportOptions(inputFormat.getFamily());

        synchronized (openOfficeConnection) {
			XFileIdentifierConverter fileContentProvider = openOfficeConnection.getFileContentProvider();
			String inputUrl = fileContentProvider.getFileURLFromSystemPath("", inputFile.getAbsolutePath());
			String outputUrl = fileContentProvider.getFileURLFromSystemPath("", outputFile.getAbsolutePath());			

			System.out.println("outputUrl = [" + outputFile.getAbsolutePath() + "]");
			System.out.println("inputUrl = [" + inputFile.getAbsolutePath() + "]");
			
			try {			
				XComponentLoader desktop = openOfficeConnection.getDesktop();
				updatesMsgSender.sendMessage(room, ReturnCode.UPDATE, "Opening document for conversion.");
				XComponent document = desktop.loadComponentFromURL(inputUrl, "_blank", 0, toPropertyValues(loadProperties));
				if (document == null) {
					updatesMsgSender.sendMessage(room, ReturnCode.FILE_NOT_FOUND, "Cannot load the document.");
					logger.error("Cannot load document from [" + inputUrl + "]");
					throw new OpenOfficeException("conversion failed: input document is null after loading");
				}
				
				totalNumPages = PageHelper.getDrawPageCount(document);
				
				document.dispose();
				
				String destDir = outputFile.getParent().toString();
				for (int i = 0; i < totalNumPages; i++) {				
					String slideName = "slide-" + i + ".pdf";
					
					updatesMsgSender.sendMessage(room, ReturnCode.EXTRACT, totalNumPages, i+1);
					
					outputUrl = destDir + File.separator + room + "-" + slideName;
					java.io.File destFile = new java.io.File(outputUrl);
					outputUrl = fileContentProvider.getFileURLFromSystemPath("", destFile.getAbsolutePath());
					System.out.println("new outputUrl = [" + outputUrl + "]");
					
					loadAndExport(inputUrl, loadProperties, outputUrl, storeProperties, i);
				}

				ArrayList<File> files = getConvertedSlides(destDir);
				
				int curSlide = 1;
				for (Iterator it = files.iterator(); it.hasNext();) {
					File aFile = (File) it.next();
					String fname = aFile.getName();
					System.out.println("Filename = [" + fname + "]");
					
					int dot = fname.lastIndexOf('.');
					fname = fname.substring(0, dot);
					fname += ".swf";
					
					File outFile = new File(aFile.getParent() + File.separator + fname);
					
					System.out.println("Input = [" + aFile.getAbsolutePath() + "]");
					System.out.println("Output = [" + outFile.getAbsolutePath() + "]");
					convertPDFtoSWF(aFile, outFile);
					updatesMsgSender.sendMessage(room, ReturnCode.CONVERT, totalNumPages, curSlide++);
				}
				
            } catch (OpenOfficeException openOfficeException) {
            	updatesMsgSender.sendMessage(room, ReturnCode.FAIL, "Failed to convert the document.");
                throw openOfficeException;
			} catch (Throwable throwable) {
				updatesMsgSender.sendMessage(room, ReturnCode.FAIL, "Failed to convert the document.");
				// difficult to provide finer grained error reporting here;
				// OOo seems to throw ErrorCodeIOException most of the time
				throw new OpenOfficeException("conversion failed", throwable);
			}
		}
	}

	private void loadAndExport(String inputUrl, Map loadProperties, String outputUrl, Map storeProperties,
			int page) throws Exception {
		XComponentLoader desktop = openOfficeConnection.getDesktop();
		XComponent document = desktop.loadComponentFromURL(inputUrl, "_blank", 0, toPropertyValues(loadProperties));
		if (document == null) {
			updatesMsgSender.sendMessage(room, ReturnCode.FILE_NOT_FOUND, "Cannot load the document.");
			logger.error("Cannot load document from [" + inputUrl + "]");
			throw new OpenOfficeException("conversion failed: input document is null after loading");
		}
	
		refreshDocument(document);

		int numPages = PageHelper.getDrawPageCount(document);
		
		document = removePagesExcept(document, page, numPages);
		
		storeProperties.put("URL", outputUrl);
		
		try {
		       XStorable saveDoc = (XStorable)UnoRuntime.queryInterface(XStorable.class, document);
		       saveDoc.storeToURL(outputUrl, toPropertyValues(storeProperties));
		} finally {
			document.dispose();
		}
	}	
	
	private XComponent removePagesExcept(XComponent doc, int exceptPage, int numPages) {
		System.out.println("Numpages = [" + numPages + "] exceptPage = [" + exceptPage + "]");
		
		for (int i = numPages - 1; i > exceptPage; i--) {
			XDrawPage xPage;
			try {
				xPage = PageHelper.getDrawPageByIndex( doc, i );
				PageHelper.removeDrawPage(doc, xPage);
			} catch (IndexOutOfBoundsException e) {
				logger.error("ERROR::Removing page = [" + i + "] exceptPage = [" + exceptPage + "]");
				updatesMsgSender.sendMessage(room, ReturnCode.FAIL, "Failed while trying to extract pages from document.");
			} catch (WrappedTargetException e) {
				logger.error("ERROR::Removing page = [" + i + "] exceptPage = [" + exceptPage + "]");
				updatesMsgSender.sendMessage(room, ReturnCode.FAIL, "Failed while trying to extract pages from document.");
			}
		}

		int firstPage = 0;
		
		for (int i = 0; i < exceptPage; i++) {
			XDrawPage xPage;
			try {			
				xPage = PageHelper.getDrawPageByIndex( doc, firstPage);
				PageHelper.removeDrawPage(doc, xPage);
			} catch (IndexOutOfBoundsException e) {
				logger.error("ERROR::Removing page = [" + i + "] exceptPage = [" + exceptPage + "]");
				updatesMsgSender.sendMessage(room, ReturnCode.FAIL, "Failed while trying to extract pages from document.");
			} catch (WrappedTargetException e) {
				logger.error("ERROR::Removing page = [" + i + "] exceptPage = [" + exceptPage + "]");
				updatesMsgSender.sendMessage(room, ReturnCode.FAIL, "Failed while trying to extract pages from document.");
			}
		}		
		
		return doc;
	}
	
	private void convertPDFtoSWF(File input, File output) {
			String SPACE = " ";
			
	        String s = null;
	        String command = swftoolConverter + SPACE + input.getAbsolutePath() + " " + output.getAbsolutePath();
	        try {
	                     
	            Process p = Runtime.getRuntime().exec(command);
	            
	            BufferedReader stdInput = new BufferedReader(new 
	                 InputStreamReader(p.getInputStream()));

	            BufferedReader stdError = new BufferedReader(new 
	                 InputStreamReader(p.getErrorStream()));

	            // read the output from the command            	            
            	logger.debug("Here is the standard output of the command:\n");
	            while ((s = stdInput.readLine()) != null) {
	                logger.debug(s);
	            }
	            
	            // read any errors from the attempted command
	            logger.debug("Here is the standard error of the command (if any):\n");
	            while ((s = stdError.readLine()) != null) {
	            	logger.error(s);
	            }
	        }
	        catch (IOException e) {
	            logger.error("exception happened - here's what I know: ");
	            e.printStackTrace();
	            updatesMsgSender.sendMessage(room, ReturnCode.SWFTOOLS, "Failed while trying to convert document to SWF.");
	        }						
	}

	private ArrayList<File> getConvertedSlides(String sourceFolder) {
		File file = new File(sourceFolder);
		
		File[] files = file.listFiles();
		
		ArrayList<File> listOfFiles = new ArrayList<File>();
		
		for (int i= 0; i < files.length; i++) {
			if (!files [i].isDirectory()) {
				String filename = (String)files[i].getName();
				if (filename.toLowerCase().endsWith(".pdf")) {
					listOfFiles.add(files[i]);	
				}
			}
		}
		
		return listOfFiles;
	}

	public void setSwftoolConverter(String swftoolConverter) {
		this.swftoolConverter = swftoolConverter;
	}	
}
