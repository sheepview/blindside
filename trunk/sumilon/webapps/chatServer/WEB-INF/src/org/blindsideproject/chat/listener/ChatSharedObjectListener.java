package org.blindsideproject.chat.listener;

import java.util.List;
import java.util.Map;

import org.red5.server.api.IAttributeStore;
import org.red5.server.api.so.ISharedObjectBase;
import org.red5.server.api.so.ISharedObjectListener;
import java.sql.Time;

/**
 * This class implements the interface ISharedObjectListener to be registered as listener of a SharedObject. 
 * Whenever there is an event occurs on SharedObject, methods of this class are automatically called.
 * 
 * @author kthiruka
 *
 */

public class ChatSharedObjectListener implements ISharedObjectListener {
	
	/**
	 * chat log storage string buffer
	 */
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

	
	/**
	 * Called when a shared object method call, newMessage() is sent using chatSO. 
	 * The chat message is extracted from the parameters passed and stored in stringBuffer.
	 * @param so chatSO SharedObject
	 * @param method method invoked
	 * @param params List of parameters passed to the method
	 *  
	 */
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
	/**
	 * To get the chat history stored in StringBuffer
	 * 
	 * @return chat History
	 */
	public String getChatLog(){
		return chatLog.toString();
	}

}
