package org.bigbluebuttonproject.fileupload.document;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import org.bigbluebuttonproject.fileupload.SlideDescriptor;
import org.springframework.web.multipart.MultipartFile;
/**
 * 
 * @author ritzalam 
 *
 */
public interface ISlideManager {
	public List<SlideDescriptor> getImages(String sourceFolder);
	
	public void saveImage(File file) throws IOException;
	
	public void saveImage(MultipartFile multipartFile) throws IOException; 
	
	public void saveFile(InputStream stream, String dir, String filename) throws IOException;
	
	public void streamImage(String name, OutputStream os);
}
 