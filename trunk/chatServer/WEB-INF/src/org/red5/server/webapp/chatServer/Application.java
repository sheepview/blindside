package org.red5.server.webapp.chatServer;

import org.red5.server.adapter.ApplicationAdapter;
import java.io.*;


public class Application extends ApplicationAdapter {
	
	StringBuffer chatLog = new StringBuffer();
	boolean inTxt = false;
	long txtPos = 0;
	
	
	public String test(String val) {
		//log.debug("test called on: " + getName());
		return val + val;
	}

	public Double add(Double a, Double b) {
		return a + b;
	}
	
	public String hello(){
		return "Hello World";
	}
	
	
	static public String getContents(File aFile) {
	    //...checks on aFile are elided
	    StringBuffer contents = new StringBuffer();
	    
	    try {
	      
	      BufferedReader input =  new BufferedReader(new FileReader(aFile));
	      try {
	        String line = null; 
	      
	        while (( line = input.readLine()) != null){
	          contents.append(line);
	          contents.append("\n");
	        }
	      }
	      finally {
	        input.close();
	      }
	    }
	    catch (IOException ex){
	      ex.printStackTrace();
	    }
	    
	    return contents.toString();
	  }
	
	public void storeChat(String message){
		int capacity = chatLog.length();
		long tempTxtPos = 0;
		RandomAccessFile raf = null;
		File f = null;
		String str = "";
		chatLog.append(message);
		chatLog.append("\n");
		
		if(capacity > 20){
			
			str = chatLog.toString();
			
			try{
				f = new File("log.txt");
				
				if(!inTxt){
					f.delete();
					f = new File("log.txt");
				}
				raf = new RandomAccessFile(f, "rw");
				raf.seek(txtPos);
				raf.write(str.getBytes());
				tempTxtPos = raf.length();
				
				// flush stringBuffer
				chatLog.delete(0, chatLog.capacity());
				
				
			}catch(Exception e){
				return;
			}
			txtPos = tempTxtPos;
			inTxt = true;
		}
		
		
	}
	
	public String getChatLog(){
		String s = "";
		
		if(inTxt){
			s = getContents(new File("log.txt"));
			s = s + chatLog.toString();
		} else{
			s = chatLog.toString();
		}
		
		return s;
	}
	
	public String testGetStringBuffer(){
		return chatLog.toString();
	}
	
	
}
