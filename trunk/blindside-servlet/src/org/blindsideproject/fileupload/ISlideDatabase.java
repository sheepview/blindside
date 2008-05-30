package org.blindsideproject.fileupload;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;
/**
 * 
 * @author ritzalam 
 *
 */
public interface ISlideDatabase {

	public List<SlideDescriptor> getSlidesForRoom(Integer room);
	
	public List<SlideDescriptor> getThumbnailsForRoom(Integer room);
	
	public File saveUploadedFile(MultipartFile multipartFile, Integer room) throws IOException;
	
	public void streamImage(Integer room, String name, OutputStream os);
	
	public void getXml(Integer room, String name, OutputStream os);
	
	public String getSlidesInXml(Integer room);
	
	public void createDefaultXml(Integer room);
	
	public void clearDatabase();
}
 
