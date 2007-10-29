package org.blindsideproject.fileupload.web;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.blindsideproject.fileupload.ISlideDatabase;
import org.blindsideproject.fileupload.SlideDescriptor;
import org.blindsideproject.fileupload.document.UnsupportedPresentationDocumentException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

public class FileUploadController extends MultiActionController {
	private final Log logger = LogFactory.getLog(getClass());
	
	private ISlideDatabase slideDatabase = null;
	
	private SlidePresentationDocument slidePres = null;

	private static final String HEADER = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
	private static final String PRESENTATIONS = "<presentations>";
	private static final String PRESENTATIONS_END_TAG = "</presentations>";
	private static final String PRESENTATION = "<presentation id=\"slides\">";
	private static final String PRESENTATION_END_TAG = "</presentation>";
	private static final String DESCRIPTION = "<description>";
	private static final String DESCRIPTION_END_TAG = "</description>";
	private static final String SLIDE = "<slide>";
	private static final String SLIDE_END_TAG = "</slide>";
	private static final String NAME = "<name>";
	private static final String NAME_END_TAG = "</name>";
	private static final String SOURCE = "<source>";
	private static final String SOURCE_END_TAG = "</source>";
	private static final String HOST = "<host>";
	private static final String HOST_END_TAG = "</host>";
	private static final String ROOM = "<room>";
	private static final String ROOM_END_TAG = "</room>";

	private static final String host = "http://localhost:8080/blindside/file/display?name=";
	
	public void setSlideDatabase(ISlideDatabase slideDatabase) {
		this.slideDatabase = slideDatabase;
	}

	public ModelAndView displaySlides(HttpServletRequest request, HttpServletResponse response) throws Exception {		

		return new ModelAndView("upload");

	}	
	
	public ModelAndView showSlides(HttpServletRequest request, HttpServletResponse response) throws Exception {		
		Integer room = new Integer(request.getParameterValues("room")[0]);
		
		logger.info("Show Slides [" + room + "]");
		
		if (room == null) return new ModelAndView("upload");
		
		return new ModelAndView("upload", "slides", getSlidesForRoom(room));
	}

	private List<SlideDescriptor> getSlidesForRoom(Integer room) {
		return this.slideDatabase.getSlidesForRoom(room);
	}

	public ModelAndView getXmlSlides(HttpServletRequest request, HttpServletResponse response) throws Exception {		
		Integer room = new Integer(request.getParameterValues("room")[0]);
		
		logger.info("Getting XML Slides [" + room + "]");
		logger.info("Servlet Path = [" + request.getServletPath() + "]");
		logger.info("Host = [" + request.getServerName() + ":" + request.getServerPort() + "]");
		logger.info("Request URI = [" + request.getRequestURI() + "]");
		logger.info("Request URL = [" + request.getRequestURL() + "]");
		
		int lastIndex = request.getRequestURL().lastIndexOf("/");
		String url = request.getRequestURL().substring(0, lastIndex);
		
		String slidesXml = createXml(url, getSlidesForRoom(room));
//		String slidesXml = this.slideDatabase.getSlidesInXml(room);
  	
		logger.info("XML Slides = " + slidesXml);
		
		response.setContentType("text/xml"); 
		response.setHeader("Cache-Control", "no-cache");

		ServletOutputStream out = response.getOutputStream();
		out.print(slidesXml);
		out.flush();
		out.close();
		return null;
	}	
	
	/**
	 * Creates an xml formatted string that is returned to the client.
	 * @param slides
	 * @return
	 */
	private String createXml(String url, List<SlideDescriptor> slides) {
		
		String displayUrl = url + "/display?name=";
		
		String slidesXml = HEADER + "\n";
		slidesXml += PRESENTATIONS + "\n" + "\t" + PRESENTATION + "\n";
		slidesXml += "\t\t" + DESCRIPTION;
		
		String description = "Presentation Slides";
		slidesXml += description + DESCRIPTION_END_TAG + "\n";
		logger.info("slidesXml = " + slidesXml);
		
		for (Iterator it = slides.iterator(); it.hasNext();) {
			slidesXml += SLIDE + NAME;
			SlideDescriptor slide = (SlideDescriptor) it.next();
			slidesXml += slide.getName() + NAME_END_TAG;
			slidesXml += SOURCE + displayUrl + slide.getName() + SOURCE_END_TAG;
			slidesXml += SLIDE_END_TAG + "\n";			
		}
		
		slidesXml += PRESENTATION_END_TAG + PRESENTATIONS_END_TAG;
		
		return slidesXml;
	}

	
	/***
	 * Don't do this for now. Need to get slides as quickly as possible.
	 * Let's do this when we can provide feedback to user through DWR.
	 * 	
	public ModelAndView showThumbnails(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String room = request.getParameterValues("room")[0];
		
		logger.info("Show Thumbnails [" + room + "]");
		
		return new ModelAndView("imageList", "slides", 
				this.slideDatabase.getThumbnailsForRoom(room));
	}	
***/
	
	public ModelAndView streamImageContent(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String filename = request.getParameterValues("name")[0];
		int firstDash = filename.indexOf('-');
		Integer room = new Integer(filename.substring(0, firstDash));
		
		// Ask browser not to chache images
		response.setHeader("Cache-Control", "no-cache");
		
		this.slideDatabase.streamImage(room, filename, response.getOutputStream());
		
		return null;
	}

	public ModelAndView processFileUpload(HttpServletRequest request, HttpServletResponse response) throws Exception {

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

		MultipartFile multipartFile = multipartRequest.getFile("pres");
		Integer conferenceRoom = new Integer(request.getParameterValues("room")[0]);

		try { 
			File file = this.slideDatabase.saveUploadedFile(multipartFile, conferenceRoom); 
			this.slideDatabase.createDefaultXml(conferenceRoom);
			slidePres.load(file, new Integer(conferenceRoom));			
		} catch (IOException e) {
			logger.error("Failed to save image into filesystem.\n" + e.getMessage());
		} catch (UnsupportedPresentationDocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return new ModelAndView("upload", "room", conferenceRoom);
	}
	
	public ModelAndView clearDatabase(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("redirect:imageList");
	}

	public void setSlidePres(SlidePresentationDocument slidePres) {
		this.slidePres = slidePres;
	}
}
