/*
  LibInstaller.java
  Copyright (C) 2004-2005  Mikael Magnusson <mikma@users.sourceforge.net>
  
  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.
  
  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
  
  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

package net.sourceforge.iaxclient;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.ObjectInputStream;
import java.io.OutputStream;
import java.net.JarURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.StringTokenizer;
import java.util.Vector;
import java.util.jar.Attributes;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;
import java.util.zip.CRC32;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.cert.Certificate;
import java.security.cert.CertificateFactory;

public class LibInstaller {
    private ClassLoader loader = getClass().getClassLoader();
    private String os;
    private String arch;
    private String cpu;
    private String javaHome;
    private String libPath;
    private String pathSeparator = File.pathSeparator;
    private String fileSeparator = File.separator;
    private File instDir;
    private boolean isWindows;

    public String getOs() { return os; }
    public String getCpu() { return cpu; }
    public ClassLoader getLoader() { return loader; }

    static public String StripBlanks(String str) {
    	StringBuffer buf = new StringBuffer();
    	int i;

    	for (i = 0; i < str.length(); i++) {
    		char c = str.charAt(i);

    		if (c != ' ')
    			buf.append(c);
    	}

    	return buf.toString();
    }

    public LibInstaller()
    {
    	os = System.getProperty("os.name").toLowerCase();
    	arch = System.getProperty("os.arch").toLowerCase();
    	javaHome = System.getProperty("java.home");
    	libPath = System.getProperty("java.library.path");
    	isWindows = os.startsWith("windows");

    	if (isWindows) {
    		os = "windows";
    	} else {
    		os = StripBlanks(os);
    	}

    	trace("OS startsWith windows:" + isWindows);

    	trace("LibInstaller ClassLoader:" + loader +
    			" " + arch + " '" + arch.substring(2) +
	      	"'");

    	// Map iX86 to x86
    	if (arch.startsWith("i") &&
    			arch.substring(2).equals("86")) {
    		trace("i386 Arch");
    		cpu = "x86";
    	} else {
    		cpu = arch;
    	}

    	trace("Cpu:" + cpu);
    	trace("libraryPath = " + getLibraryPath());
    	
    	instDir = new File(getLibraryPath());
    }

    /** Check if any files of library name need to be updated.
     @param name Library name */
    public boolean checkLibrary(String name)
	throws IOException
    {
    	Md5Entry entry = new Md5Entry();
    	entry.init(name);
	
    	if (entry.isEmpty()) {
    		trace("md5map is empty");
    		return true;
    	}

    	Vector newlibs =
    		getLibrariesToUpdate(instDir, entry);
	
    	return newlibs.size() == 0;
    }

    /** Install library */
    public void installLibrary(URL baseUrl, String name)
	throws IOException
    {
    	Md5Entry entry = new Md5Entry();
    	entry.init(name);
	
    	if (entry.isEmpty()) {
    		return;
    	}
	
    	Vector newlibs =
    		getLibrariesToUpdate(instDir, entry);
	
    	if (newlibs.size() == 0) {
    		System.out.println("No new libraries");
    	}
	
    	trace("URL: " + baseUrl + " " + name);
    	URL libBaseUrl = getLibraryURLBase(baseUrl, name);
	
    	installLibraries(libBaseUrl, newlibs);    
    }

    /** Open URL connection to resource */
    protected URLConnection openResource(String name)
	throws IOException
    {
    	URL url = loader.getResource(name);

    	if (url == null) {
    		throw new IOException("Can't find resource `" + name + "'");
    	}

    	URLConnection conn = url.openConnection();

    	trace("openResource " + name + " " + conn);
	
    	return conn;
    }

    protected File searchLibPath(String libName)
	throws IOException
    {
    	StringTokenizer st = new StringTokenizer(libPath, pathSeparator);

    	while (st.hasMoreTokens()) {
    		String dirName = st.nextToken();

    		File file = new File(dirName, libName);

    		if (file.exists()) {
    			return file;
    		}
    	}
	
    	throw new IOException("Can't find `" + libName +
			      "' in library path " + libPath);
    }

    /** Check if md5 summs in md5map and installed libraries corresponds */
    protected Vector getLibrariesToUpdate(File instDir, Md5Entry entry)
    {
    	Vector toUpdate = new Vector();
    	Hashtable md5Map = entry.getMap();
    	long md5Modified = entry.getTime();
	
    	for (Enumeration enu = md5Map.keys() ; enu.hasMoreElements() ;) {
    		String libName = (String)enu.nextElement();
    		String libMd5 = (String)md5Map.get(libName);

    		File instFile = null;

    		try {
    			instFile = searchLibPath(libName);
    		} catch(IOException e) {
    			//e.printStackTrace();
    			System.out.println("Library missing:" + libName);
    			toUpdate.addElement(libName);
    			break;
    		}

    		try {
    			String instMd5 = calcMD5(instFile);
		
    			if (!instMd5.equals(libMd5)) {
    				System.out.println("Md5sums not matching:" + libName);
    				System.out.println("Installed:'" + instMd5 + "'");
    				System.out.println("Source:   '" + libMd5 + "'");
    				toUpdate.addElement(libName);
    				break;
    			}
    		} catch(NoSuchAlgorithmException e) {
    			e.printStackTrace();
    		} catch(IOException e) {
    			e.printStackTrace();
    		}

    		long instModified = instFile.lastModified();

    		if (md5Modified > instModified) {
    			System.out.println("Md5sums newer:" + libName);
    			toUpdate.addElement(libName);
    			break;
    		}
    	}

    	return toUpdate;
    }

    /** Get last modification date from JarURLConnection or URLConnection */
    protected long getLastModified(URLConnection conn)
	throws IOException
    {
    	long md5Modified = 0;
	
    	if (conn instanceof JarURLConnection) {
    		JarURLConnection jarConn = (JarURLConnection)conn;
    		JarEntry entry = jarConn.getJarEntry();
	    
    		if (entry != null) {
    			md5Modified = entry.getTime();
    		}
    	} else {
    		md5Modified = conn.getLastModified();
    	}

    	return md5Modified;
    }

    /** Load map (lib -> md5) from md5 file resource */
    protected Hashtable loadMd5Hashtable(InputStream in)
	throws IOException
    {
    	Hashtable map = new Hashtable();
    	BufferedReader ir = new BufferedReader(new InputStreamReader(in));
	
    	while(ir.ready()) {
    		String line = ir.readLine();

    		if (line == null) {
    			break;
    		}

    		StringTokenizer st = new StringTokenizer(line);
 
    		if (!st.hasMoreTokens()) {
    			continue;
    		}
    		String md5 = st.nextToken();

    		if (!st.hasMoreTokens()) {
    			continue;
    		}
    		String filename = st.nextToken();

    		if (filename.startsWith("*")) {
    			filename = filename.substring(1);
    		}

    		map.put(filename, md5);
    	}

    	return map;
    }

    /** Install libraries xxx */
    protected void installLibraries(URL libBaseUrl, Vector newlibs)
	throws IOException
    {
    	JarFile libJar;

    	try {
    		URL libUrl =
    			new URL("jar:" + libBaseUrl + ".jar!/");
	
    		JarURLConnection jarConn =
    			(JarURLConnection)libUrl.openConnection();

    		trace("open jar " + libUrl + " " + jarConn);

    		libJar = jarConn.getJarFile();
    	} catch(IOException e) {
    		e.printStackTrace();
    		return;
    	}

    	if (!instDir.exists()) {
    		instDir.mkdir();
    	}

    	for (Enumeration enu = newlibs.elements(); enu.hasMoreElements() ;) {
    		String libName = (String)enu.nextElement();
    		JarEntry libEntry = libJar.getJarEntry(libName);
	    
    		if (libEntry != null) {
    			installLibrary(instDir, libJar, libEntry);
    		}
    	}
    }

    // TODO: verify certificate or jarfile
// 	{
// 	    try {
// 		CertificateFactory cf =
// 		    CertificateFactory.getInstance("X.509");
// 		JarEntry je = jar.getJarEntry("META-INF/JIAXCLIE.DSA");
// 		InputStream fis = jar.getInputStream(je);
// 		ObjectInputStream p = new ObjectInputStream(fis);
// 		Object c = p.readObject();

// 		System.out.println(c);
// 	    } catch(java.security.cert.CertificateException e) {
// 		e.printStackTrace();
// 	    } catch(ClassNotFoundException e) {
// 		e.printStackTrace();
// 	    }
// 	}

    /** Install library from jar entry */
    protected boolean installLibrary(File instDir,
				     JarFile jar,
				     JarEntry libEntry)
	throws IOException
    {
    	String libName = libEntry.getName(); 
    	File instFile = new File(instDir, libName);

    	InputStream in = jar.getInputStream(libEntry);

    	trace("Installing " + libName + " to " + instDir);
    	writeStreamToFile(instFile, in);

    	return true;
    }

    /** Base url for library jar */
    protected URL getLibraryURLBase(URL baseUrl, String libName)
	throws MalformedURLException
    {
    	trace("getLibrary baseUrl = " + baseUrl);
    	
    	return new URL(baseUrl, libName + "_" + os + "_" + cpu);
    }

    /** Write input stream to a file */
    protected void writeStreamToFile(File file, InputStream in)
	throws IOException
    {
    	OutputStream out = new FileOutputStream(file);
	
    	try {
    		byte[] buf = new byte[1024];
	    
    		while (true) {
    			int res = in.read(buf);
		
    			if (res < 0)
    				break;
		
    			out.write(buf, 0, res);
	    }
    	} finally {
    		out.close();
    	}	    
    }

    /** Directory path for installation of Java native library */
    protected String getLibraryPath()
    {
    	String dirName;

    	if (isWindows) {
    		return javaHome + fileSeparator + "bin" + fileSeparator;
    	} else {
    		return javaHome + fileSeparator + "lib" + fileSeparator + arch;
    	}
    }

//     // Map to architecture dependent library name
//     protected String mapLibraryName(String name)
//     {
// 	String libPrefix;
// 	String libPostfix;

// 	if (isWindows) {
// 	    libPrefix = "";
// 	    libPostfix = ".dll";
// 	} else {
// 	    libPrefix = "lib";
// 	    libPostfix = ".so";
// 	}

// 	return libPrefix + name + libPostfix;
//     }

    /** Calculate MD5 sum of a file */
    protected String calcMD5(File file)
	throws IOException, NoSuchAlgorithmException
    {
    	MessageDigest md = MessageDigest.getInstance("MD5");
	
    	FileInputStream input = new FileInputStream(file);
    	byte[] buf = new byte[1024];
	
    	while (input.available() > 0) {
    		int res = input.read(buf, 0, buf.length);
	    
    		md.update(buf, 0, res);
    	}
	
    	byte[] md5 = md.digest();
	
    	return bytesToHexString(md5);
    }

    /** Convert an array of bytes
	to a string of hexadecimal numbers */
    protected String bytesToHexString(byte[] array)
    {
    	StringBuffer res = new StringBuffer();

    	for (int i=0; i < array.length; i++) {
    		int val = array[i] + 256;
    		String b = "00" + Integer.toHexString(val);
    		int len = b.length();
    		String sub = b.substring(len - 2);

    		res.append(sub);
    	}

    	return res.toString();
    }

//     // Calculate CRC of file
//     protected long calcCrc(File file)
//     {
// 	try {
// 	    CRC32 crc = new CRC32();
// 	    FileInputStream input = new FileInputStream(file);
// 	    byte[] buf = new byte[1024];
	    
// 	    while (input.available() > 0) {
// 		int res = input.read(buf, 0, buf.length);
		
// 		crc.update(buf, 0, res);
// 	    }
	    
// 	    return crc.getValue();
// 	} catch (java.io.IOException e) {
// 	    e.printStackTrace();
// 	    return -1;
// 	}
//     }

    protected static void trace(String s)
    {
	  System.out.println(s);
    }

    protected class Md5Entry
    {
    	private JarEntry md5entry;
    	private Hashtable md5map;

    	boolean init(String name)
	    throws IOException
	    {
    		String libarch = name + "_" + getOs() + "_" + getCpu();
    		String md5jar = libarch + "_md5.jar";
    		String md5name = libarch + ".md5";
	    
    		trace("md5jar = " + md5jar);
	    
    		URL md5url = getLoader().getResource(md5jar);

    		if (md5url == null) {
    			throw new IOException("Can't get " + md5jar);
    		}

    		trace("md5url:" + md5url);
    		URL jarurl = new URL("jar:" + md5url + "!/" + md5name);
    		JarURLConnection jarconn =
    			(JarURLConnection)jarurl.openConnection();
	    
    		JarFile jar = jarconn.getJarFile();
    		md5entry = jar.getJarEntry(md5name);
    		InputStream in = jar.getInputStream(md5entry);
    		md5map = loadMd5Hashtable(in);

    		return true;
	    }

    	boolean isEmpty() { return md5map.isEmpty(); }

    	Hashtable getMap() { return md5map; }

    	long getTime() {
    		// 	try {
    		// 	    md5Modified = md5entry.getTime();
    		// 	} catch(IOException e) {
    		// 	    e.printStackTrace();
    		// 	}
    		return md5entry.getTime();
    	}
    }
}
