package org.bigbluebuttonproject.fileupload.manager;

import java.util.ArrayList;

import org.blindsideproject.fileupload.document.IProgressListener;
/**
 * 
 * @author ritzalam 
 *
 */
public class UploadListener implements IProgressListener{
	private String roomNo;
	private ArrayList <String> messages = new ArrayList <String> ();
	
	public void update(String newMessage)
	{
	}
		
	public UploadListener (String roomNo)
	{
		this.roomNo = roomNo;
	}
		
	public void addUpdatedMessages(String newMessage)
	{
		messages.add(newMessage);
	}
	
	public ArrayList getUpdatedMessages()
	{
		return messages;
	}
	
	public void setArrayList(ArrayList<String> messages)
	{
		this.messages = messages;
	}

}
