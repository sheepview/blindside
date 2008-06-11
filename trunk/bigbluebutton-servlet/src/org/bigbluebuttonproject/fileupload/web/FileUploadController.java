package org.bigbluebuttonproject.fileupload.web;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bigbluebuttonproject.fileupload.ISlideDatabase;
import org.bigbluebuttonproject.fileupload.SlideDescriptor;
import org.bigbluebuttonproject.fileupload.document.UnsupportedPresentationDocumentException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;


/**
 * This is the base class of blindside-servlet, which listen to the HTTP requests from blindside clients (Extends MultiActionController for this purpose). 
 * Requests from clients can be: File upload, Request for Slides, Request for slideXML or Request for slide descriptors 
 * 
 * This class uses FileSystemSlideManager.java and SlidePresentationDocument.java (keeping instances of those two classes).
 * Basically, this class is used as an adapter class which relays Http client requests to other classes. 
 * 
 * 
 * 
 * Configuration that maps the Client requests to the methods of this class in blindside-servlet.xml 
 * <property name="methodNameResolver">
 *			<bean class="org.springframework.web.servlet.mvc.multiaction.PropertiesMethodNameResolver">
 *			<property name="mappings">
 *				<props>
 *					<prop key="/showslides">displaySlides</prop>
 *					<prop key="/slides">showSlides</prop>
 *					<prop key="/xmlslides">getXmlSlides</prop>
 *					<!--prop key="/thumbnails">showThumbnails</prop-->
 *					<prop key="/display">streamImageContent</prop>
 *					<prop key="/upload">processFileUpload</prop>
 *					<prop key="/clearDatabase">clearDatabase</prop>
 *				</props>
 *			</property>
 *		</bean>
 *	</property>
 * 
 * 
 * 
 * @author ritzalam 
 *
 */
public class FileUploadController extends MultiActionController {
	
	// register logging service
	private final Log logger = LogFactory.getLog(getClass());
	
	/**
	 * FileSystemSlideManager implements ISlideDatabase
	 */
	private ISlideDatabase slideDatabase = null;
	
	/**
	 * Used for loading saved slide presentation files before sending them to client
	 */
	private SlidePresentationDocument slidePres = null;
	
	/**
	 * Used for SlideXML creation. SlideXML holds the description of slides 
	 */
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

	
	private static final String host = "http://localhost:8080/bigbluebutton/file/display?name=";
	
	/**
	 * Setter for slideDatabase
	 * 
	 * @param slideDatabase
	 */
	public void setSlideDatabase(ISlideDatabase slideDatabase) {
		this.slideDatabase = slideDatabase;
	}

	public ModelAndView displaySlides(HttpServletRequest request, HttpServletResponse response) throws Exception {		

		return new ModelAndView("upload");

	}	
	/**
	 * This method sends the List of slide descriptors for the room (given roomID) to HttpServletResponse.
	 * Calls getSlidesForRoom() method from FileSystemSlideManager class
	 * 
	 * @param request HttpServletRequest
	 * @param response HttpServletResponse
	 * 
	 */
	public ModelAndView showSlides(HttpServletRequest request, HttpServletResponse response) throws Exception {		
		Integer room = new Integer(request.getParameterValues("room")[0]);
		
		logger.info("Show Slides [" + room + "]");
		
		if (room == null) return new ModelAndView("upload");
		
		return new ModelAndView("upload", "slides", getSlidesForRoom(room));
	}
	
	/**
	 * This method returns the List of slide descriptors for the room (given roomID).
	 * Calls getSlidesForRoom() method from FileSystemSlideManager class
	 * 
	 * @param room RoomID
	 * @return List of SlideDescriptors of corresponding room
	 */
	private List<SlideDescriptor> getSlidesForRoom(Integer room) {
		return this.slideDatabase.getSlidesForRoom(room);
	}
	/**
	 * This handler method overwriting the method in MultiActionController. 
	 * Its purpose is to stream slide XML from server to the HTTP response. 
	 * It writes the response using HttpServletResponse. 
	 * 
	 * @param request HttpServletRequest
	 * @param response HttpServletResponse where the Slide XML is sent
	 * 
	 */
	public ModelAndView getXmlSlides(HttpServletRequest request, HttpServletResponse response) throws Exception {		
		Integer room = new Integer(request.getParameterValues("room")[0]);
		
		logger.info("Getting XML Slides [" + room + "]");
		logger.info("Servlet Path = [" + request.getServletPath() + "]");
		logger.info("Host = [" + request.getServerName() + ":" + request.getServerPort() + "]");
		logger.info("Request URI = [" + request.getRequestURI() + "]");
		logger.info("Request URL = [" + request.getRequestURL() + "]");
		
		// get URL from client request
		int lastIndex = request.getRequestURL().lastIndexOf("/");
		String url = request.getRequestURL().substring(0, lastIndex);
		
		// create slide presentation descriptor XML
		String slidesXml = createXml(url, getSlidesForRoom(room));
//		String slidesXml = this.slideDatabase.getSlidesInXml(room);
  	
		logger.info("XML Slides = " + slidesXml);
		
		// before sending the xml string to the client,
		// set content type and header
		response.setContentType("text/xml");
		//Ask browser not to chache images
		response.setHeader("Cache-Control", "no-cache");
		
		// get ServletOutputStream from HttpServletResponse
		ServletOutputStream out = response.getOutputStream();
		// send the xml string to client
		out.print(slidesXml);
		out.flush();
		out.close();
		return null;
	}	
	
	/**
	 * This method creates an xml formatted string (Slide description) that is returned to the client.
	 * 
	 * @param url URL address from client's HttpRequest
	 * @param slides List of SlideDescriptors  
	 * @return SlidesXML
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

	
	/*
	 * Don't do this for now. Need to get slides as quickly as possible.
	 * Let's do this when we can provide feedback to user through DWR.
	 * 	
	public ModelAndView showThumbnails(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String room = request.getParameterValues("room")[0];
		
		logger.info("Show Thumbnails [" + room + "]");
		
		return new ModelAndView("imageList", "slides", 
				this.slideDatabase.getThumbnailsForRoom(room));
	}	
*/
	
	/**
	 * This handler method overwriting the method in MultiActionController. 
	 * Its purpose is to stream slide content from server to the HTTP response. 
	 * It writes the response using HttpServletResponse parameter. 
	 * 
	 * @param request HttpServletRequest
	 * @param response HttpServletResponse where the image is sent
	 * 
	 */
	
	public ModelAndView streamImageContent(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String filename = request.getParameterValues("name")[0];
		int firstDash = filename.indexOf('-');
		Integer room = new Integer(filename.substring(0, firstDash));
		
		// Ask browser not to chache images
		response.setHeader("Cache-Control", "no-cache");
		// call streamImage method in FileSystemSlideManager to stream slide to client
		this.slideDatabase.streamImage(room, filename, response.getOutputStream());
		
		return null;
	}
	/**
	 * This method is called when the client HTTP request for file upload.
	 * Calls saveUploadedFile() from FileSystemManager class to save uploaded pdf file from client. 
	 * Also creates Slide description XML file by calling createDefaultXml() from FileSystemManager class
	 * 
	 * @param request
	 * @param response HttpServletResponse
	 * @return
	 * @throws Exception
	 */
	public ModelAndView processFileUpload(HttpServletRequest request, HttpServletResponse response) throws Exception {

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		// MultipartFile is a copy of file in memory, not in file system
		MultipartFile multipartFile = multipartRequest.getFile("pres");
		// get Room ID from HttpServletRequest
		Integer conferenceRoom = new Integer(request.getParameterValues("room")[0]);

		try { 
			// save MultipartFile in server fileSystem by calling saveUploadedFile in FileSystemSlideManager class
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
	/**
	 * Setter for slidePres
	 * 
	 * @param slidePres
	 */
	public void setSlidePres(SlidePresentationDocument slidePres) {
		this.slidePres = slidePres;
	}
}
