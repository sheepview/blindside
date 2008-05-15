package org.blindsideproject.chat.listener;

import org.red5.server.api.so.ISharedObject;
import org.red5.server.api.so.ISharedObjectListener;
import java.util.*;
import org.red5.server.api.so.ISharedObjectBase;
import org.red5.server.api.IAttributeStore;

public class ChatSharedObjectListener implements ISharedObjectListener {

	  
	StringBuffer chatLog = new StringBuffer();
	// The handler <method> of the shared object <so> was called
	// with the parameters <params>.
	public void onSharedObjectSend(ISharedObjectBase so,
              String method, List params) {
		
		System.out.println("\n\n" + (String)params.get(0) + "\n\n");
		
		if(method.equals("newMessage")){
			
			chatLog.append((String)params.get(0));
			chatLog.append("\n");
		}
		  
	}
	   
	  
	public void onSharedObjectConnect(ISharedObjectBase so){}
	public void onSharedObjectDisconnect(ISharedObjectBase so){}
	public void onSharedObjectClear(ISharedObjectBase so){}
	public void onSharedObjectUpdate(ISharedObjectBase so, IAttributeStore values){}
	public void onSharedObjectUpdate(ISharedObjectBase so,String s,Object o){}
	public void onSharedObjectUpdate(ISharedObject so, String key, Object value) {}
	public void onSharedObjectUpdate(ISharedObjectBase so, Map<String,Object> values){}
	public void onSharedObjectDelete(ISharedObjectBase so, String key) {}
	public void onSharedObjectDelete(ISharedObjectBase so, String key, Object q) {}
	  
	public String getChatLog(){
		return chatLog.toString();
	}
	 
}



