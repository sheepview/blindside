
package org.blindsideproject.chat;

import org.blindsideproject.chat.listener.ChatSharedObjectListener;
import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.service.IPendingServiceCall;
import org.red5.server.api.service.IPendingServiceCallback;
import org.red5.server.api.service.IServiceCapableConnection;
import org.red5.server.api.so.ISharedObject;
import org.red5.server.api.Red5;



public class Application extends ApplicationAdapter implements
			IPendingServiceCallback{
	
	IScope appScope = null;
	// Chat SharedObject Listener to listen to the changes on sharedobject
	ChatSharedObjectListener chatListener = null;
	
	
  public boolean roomStart(IScope room) {

      if (!super.roomStart(room))
          return false;
      
      createSharedObject(room, "chatSO", true);
      ISharedObject so = getSharedObject(room, "chatSO");
     
      chatListener = new ChatSharedObjectListener();
      so.addSharedObjectListener(chatListener);
      
      return true;            
  }
  
  
  public boolean appStart (IScope app )
  {

      appScope = app;
      return true;
  }
  


  public void appStop ( )
  {

  }

  public boolean appConnect( IConnection conn, Object[] params)
  {

    	
      return true;
  }
  public void appDisconnect(IConnection conn)
  {
	  
  }
  public boolean roomConnect(IConnection conn, Object[] params) {
	  
	  if (conn instanceof IServiceCapableConnection) {
		  	System.out.println("roomConnect: Wnent inside IF");
		    IServiceCapableConnection sc = (IServiceCapableConnection) conn;
		    String chatLog = chatListener.getChatLog();

		    sc.invoke("setChatLog", new Object[]{chatLog}, this);
		}
	  log.info("Blindside::Chat::roomConnect - " + conn.getClient().getId());
	  
	  return true;
  }
  
  public void roomLeave(IClient client, IScope room) {

	  super.roomLeave(client, room);
	  log.info("Blindside::Chat::roomLeave - " + client.getId());
  	

  }
  
  public boolean roomJoin(IClient client, IScope room) {
	  super.roomJoin(client, room); 
	  IConnection conn = Red5.getConnectionLocal();
	  log.info("Blindside::Chat::roomJoin - " + client.getId());
  	
	  return true; 
  }    
  
  public void resultReceived(IPendingServiceCall call) {
		log.info("Received result " + call.getResult() + " for "
				+ call.getServiceMethodName());		
	}  
  
}
