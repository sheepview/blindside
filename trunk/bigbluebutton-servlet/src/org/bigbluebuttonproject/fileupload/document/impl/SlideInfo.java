package org.bigbluebuttonproject.fileupload.document.impl;

import org.bigbluebuttonproject.fileupload.document.impl.PptToJpegConverter;


public class SlideInfo{

	public SlideInfo(String strName, String strPath, PptToJpegConverter format){
		this.strName = strName;
		this.strPath = strPath;
		this.format = format;
	}


	public String getName(){
		return strName;
	}
	
	public String getPath(){
		return strPath;
	}
	
	public PptToJpegConverter getFormat(){
		return format;
	}
	
	private String strName;
	private String strPath;
	private PptToJpegConverter format;

}