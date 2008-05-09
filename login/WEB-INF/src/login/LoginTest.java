package login;

/**
 * This is a tester class for the server-side application. It does not get executed when
 * the server is running, it is just a test case for the Login application
 * @author dzgonjan
 *
 */
public class LoginTest {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		LoginLookup l = new LoginLookup();
		l.addUser("test", "test");
		l.addUser("denis", "12345");
		l.addUser("jib", "jab");
		l.saveToFile("users.xml");
	}

}
