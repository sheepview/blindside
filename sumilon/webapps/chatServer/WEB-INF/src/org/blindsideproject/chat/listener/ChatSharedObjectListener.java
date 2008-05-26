package org.blindsideproject.chat.listener;

import java.util.List;
import java.util.Map;

import org.red5.server.api.IAttributeStore;
import org.red5.server.api.so.ISharedObjectBase;
import org.red5.server.api.so.ISharedObjectListener;
import java.sql.Time;

public class ChatSharedObjectListener implements ISharedObjectListener {
	
	StringBuffer chatLog = new StringBuffer();
	@Override
	public void onSharedObjectClear(ISharedObjectBase so) {
		// TODO Auto-generated method stub

	}

	@Override
	public void onSharedObjectConnect(ISharedObjectBase so) {
		// TODO Auto-generated method stub

	}

	@Override
	public void onSharedObjectDelete(ISharedObjectBase so, String key) {
		// TODO Auto-generated method stub

	}

	@Override
	public void onSharedObjectDisconnect(ISharedObjectBase so) {
		// TODO Auto-generated method stub

	}

	@Override
	public void onSharedObjectSend(ISharedObjectBase so, String method,
			List params) {
		//System.out.println("\n\n" + (String)params.get(0) + "\n\n");
	 	 
		if(method.equals("newMessage")){
			
			chatLog.append("[" + new Time(System.currentTimeMillis())+ "] "+(String)params.get(0));
			chatLog.append("\n");
		}

	}

	@Override
	public void onSharedObjectUpdate(ISharedObjectBase so, String key,
			Object value) {
		// TODO Auto-generated method stub

	}

	@Override
	public void onSharedObjectUpdate(ISharedObjectBase so,
			IAttributeStore values) {
		// TODO Auto-generated method stub

	}

	@Override
	public void onSharedObjectUpdate(ISharedObjectBase so,
			Map<String, Object> values) {
		// TODO Auto-generated method stub

	}
	
	public String getChatLog(){
		return chatLog.toString();
	}

}
