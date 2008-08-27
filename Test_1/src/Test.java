
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;



public class Test {

	protected String host = "134.117.58.103";
	protected String room = "85115";
	protected String file = "session_";
	protected String root = "C:/";
	protected static String MP3url = null;
	
	//public static Keyboard key;  

	
	public Test() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String date = null;
		date = getTimestamp();
		System.out.println(date);
		//getArgs(args);
		//String pathName = Keyboard.getString();
		//boolean test = mkDirVCR("c:\\TestVCR\\");
		//String source = new String ("C:\\Test upload");
		//String target = new String ("C:\\Test upload123");
		//copyDirectory( source , target);
		//System.out.println("press anyKey!");
		//char a = Keyboard.getCharacter();
		//System.out.println(a);
		String str = convertCall("5901");
		System.out.println(str);
			

	}

	public void getArgs(String args[]) {
		
		host = args[0];
		room = args[1];
		file = args[2];
		String date = getTimestamp();
		file = file.concat(room+"_");
		file = file.concat(date.toString());
		file = file.concat(".xml");
		file = root.concat(file);
		System.out.println(host);
		System.out.println(room);
		System.out.println(file);
							
		}
	
	public static String getTimestamp() {
	
	DateFormat dateFormat = new SimpleDateFormat("yyyy_MM_dd HH_mm");
    Date date = new Date();
  
    return dateFormat.format(date);
    
	//	return System.currentTimeMillis();
	}
	
	public static boolean mkDirVCR (String pathname){
		
		  try{
			    //String strDirectoy ="testvcr.txt";
			    //String strManyDirectories="c:\\TestVCR\\";

			    // Create one directory
			    boolean success = (new File(pathname)).mkdir();
			    if (!success) {
			      System.out.println("Directory: " + pathname + " could not be created");			      
			      return false;
			    }    
			    
			    System.out.println("Directory: " + pathname + " was created");
			  
			   /* // Create multiple directories
			    success = (new File(strManyDirectories)).mkdirs();
			    if (success) {
			      System.out.println("Directories: " + strManyDirectories + " created");
			    }*/

			    }catch (Exception e){//Catch exception if any
			      System.err.println("Error: " + e.getMessage());
			      return false;
			    }
			    return true;
	}
	
	 // If targetLocation does not exist, it will be created.
    public static void copyDirectory( String sourcePath , String targetPath){
    
    	File sourceLocation = new File (sourcePath);
    	
    	File targetLocation = new File (targetPath);
    	    	
    	try {
            
            if (sourceLocation.isDirectory()) {
                if (!targetLocation.exists()) {
                    targetLocation.mkdir();
                }
                
                String[] children = sourceLocation.list();
                for (int i=0; i<children.length; i++) {
                   File source = new File(sourceLocation, children[i]);
                   File target = new File(targetLocation, children[i]);
                	copyDirectory(source.getPath(), target.getPath());
                }
            } else {
                
                InputStream in = new FileInputStream(sourceLocation);
                OutputStream out = new FileOutputStream(targetLocation);
                
                // Copy the bits from instream to outstream
                byte[] buf = new byte[1024];
                int len;
                while ((len = in.read(buf)) > 0) {
                    out.write(buf, 0, len);
                }
                in.close();
                out.close();
            }
        }catch (IOException e) {
        	{//Catch exception if any
			      System.err.println("Error: " + e.getMessage());
        	}
        }
    }
   public static String convertCall(String room){
	   
	   // http://134.117.254.226/cgi-bin/convert.pl?id=<id>
	   //ex:  http://134.117.254.226/cgi-bin/convert.pl?id=5901
	   
	   String HTTPrequest = new String ("http://134.117.254.226/cgi-bin/convert.pl?id=");
	   HTTPrequest = HTTPrequest.concat(room);
	   System.out.println("The link is "+ HTTPrequest);
	   String str = null;
	   try {
		   URL convert = new URL (HTTPrequest);
		   HttpURLConnection u = (HttpURLConnection)convert.openConnection();
		   BufferedReader in = new BufferedReader(new InputStreamReader(u.getInputStream()));
		   str = in.readLine();
		   System.out.println(str);
		   in.close();
		   /*u.setRequestMethod("http://134.117.254.226/cgi-bin/convert.pl?id=85901");
		   MP3url=u.getRequestMethod();
		   System.out.println("URLMP3: "+ MP3url);*/
		   u.disconnect();
		   }catch (Exception e){
		   System.out.println(e);
	   }
	   return str;
   }
    
}
