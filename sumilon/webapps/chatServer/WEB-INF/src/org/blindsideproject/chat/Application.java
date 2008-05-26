
package org.blindsideproject.chat;


 

import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.service.IPendingServiceCall;
import org.red5.server.api.service.IPendingServiceCallback;
import org.red5.server.api.service.IServiceCapableConnection;
import org.red5.server.api.so.ISharedObject;
import org.blindsideproject.chat.listener.ChatSharedObjectListener;

public class Application extends ApplicationAdapter 
				implements IPendingServiceCallback
{

	//listener object for chatSO sharedobject
		ChatSharedObjectListener chatListener = null;
		
		boolean debugMode = true;
	
	  // Automatically Called when chatServer is started by Red5/ant
	  public boolean appStart (IScope app)
	  {
	      return true;
	  }
	  //Automatically Called when chatServer is stopped
	  public void appStop ( )
	  {
		 
	  }
	  // Called when chat room is started by the first client
	  public boolean roomStart(IScope room) {
		  // create a sharedobject with the name chatSO
		  
		  if(!hasSharedObject(room, "chatSO")){
			  if(!createSharedObject(room, "chatSO", true))
				  System.out.println("Sharedobject::chatSO could not be created");
		  }
	      ISharedObject so = getSharedObject(room, "chatSO", true);
	      
	      if(so == null){
	    	  System.out.println("SharedObject was not created");
	    	  return false;
	      }
	      
	      // create a SharedObject listener and register it to listen on chatSO
	      chatListener = new ChatSharedObjectListener();
	      so.addSharedObjectListener(chatListener);
	      
	      
	      
	      
	      return true;            
	  }
	  // Called when last client leaves the chat room
	  public void roomLeave(IClient client, IScope room) {

	  }
	  // Called whenever a new client joins the chat room
	  public boolean roomJoin(IClient client, IScope room) {
	     	
		  System.out.println("\n\n CLIENT ID IS: " + client.getId());
	  	
		  return true;
	  } 
	  // called whenever client connects to the chat room
	  public boolean roomConnect(IConnection conn, Object[] params) {

		  if (conn instanceof IServiceCapableConnection) {
//			  System.out.println("roomConnect: Wnent inside IF");
			  IServiceCapableConnection sc = (IServiceCapableConnection) conn;
			  String chatLog = chatListener.getChatLog();

			  sc.invoke("setChatLog", new Object[]{chatLog});
		  }
		  
		

	  	  return true;
	  }
	    
	  public void resultReceived(IPendingServiceCall call) {
//			log.info("Received result " + call.getResult() + " for "
//					+ call.getServiceMethodName());		
		}
	  
}