/*
 * This file is part of WebHuddle.
 * Copyright (c) 2001-2004 WebHuddle, Inc.  All Rights Reserved.
 * 
 * WebHuddle is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * WebHuddle is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with WebHuddle; see the file LICENSE.txt.  If not, write 
 * to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, 
 * Boston, MA  02111-1307  USA
 *
 */

package org.blindsideproject.fileupload.document.impl;

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