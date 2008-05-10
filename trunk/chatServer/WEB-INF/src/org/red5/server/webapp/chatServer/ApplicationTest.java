package org.red5.server.webapp.chatServer;

import junit.framework.TestCase;
import junit.framework.TestSuite;
import junit.framework.Test;

public class ApplicationTest extends TestCase {

	String chat1, chat2, chat3, chat4;
	Application app;
	
	public ApplicationTest(String name){
		super(name);
	}
	
		
	protected void setUp() throws Exception {
		app = new Application();
		chat1 = "Hello, How are u";
		chat2 = "I am fine, thank you";
		chat3 = "how is ur work?";
		chat4 = "its going good";
	}

	protected void tearDown() throws Exception {
		app = null;
		chat1 = chat2 = chat3 =  chat4 = null;
	}

	
	public void testStoreChat() {
		
		app.storeChat(chat1);
		String expected = chat1 +"\n";
		assertTrue(app.getChatLog().equals(expected));
		System.out.println("Actual ChatLog Stored:" + app.getChatLog());
		System.out.println("Contents in Buffer:" + app.testGetStringBuffer());
		System.out.println("____________________________________________________________");
		
		
		expected = expected + chat2 + "\n";
		app.storeChat(chat2);
		assertTrue(app.getChatLog().equals(expected));
		System.out.println("Actual ChatLog Stored:" + app.getChatLog());
		System.out.println("Contents in Buffer:" + app.testGetStringBuffer());
		System.out.println("____________________________________________________________");
		
		expected = expected + chat3 + "\n";
		app.storeChat(chat3);
		assertTrue(app.getChatLog().equals(expected));
		System.out.println("Actual ChatLog Stored:" + app.getChatLog());
		System.out.println("Contents in Buffer:" + app.testGetStringBuffer());
		System.out.println("____________________________________________________________");
		
		expected = expected + chat4 + "\n";
		app.storeChat(chat4);
		assertTrue(app.getChatLog().equals(expected));
		System.out.println("Actual ChatLog Stored:" + app.getChatLog());
		System.out.println("Contents in Buffer:" + app.testGetStringBuffer());
		System.out.println("____________________________________________________________");
		
		//fail("Not yet implemented");
	}
	
	public static Test suite(){
        TestSuite suite = new TestSuite();
        suite.addTest(new ApplicationTest("testStoreChat"));
        return suite;
    }



	
}
