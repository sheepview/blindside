HI,


This group of fourth year students developed the sip phone which would integrate into blindside. Before you start to re develop it we highly recommend that you follow these simple steps to be able to create a project using the work we have done. 

To create a project:

1. Download the code from SVN checkout using your eclipse ide.

2. If you don’t have that option in eclipse, download tortoise SVN from
  http://tortoisesvn.tigris.org/

3. Ensure you add all the jar files except SipPhoneApplet.jar to your build path
    (Right click on the project-Buildpath-configure build path)

4. To run the applet, right click on SipPhoneApplet.java and run as applet.
    If eclipse doesn’t recognize it, follow the following steps:

a.	Right click on SipPhoneApplet.java and run
b.	Select option as run as applet
c.	In the project field enter “sipphone”
d.	In the applet field enter “com.sipresponse.callapplet.SipPhoneApplet”

5. In order to capture from applets you will have to download JMF 2.1.1 e from
http://java.sun.com/products/java-media/jmf/

6. Install it.

7. In JMF registry editor, check the “Allow capture from applet” option.

8. Run the applet (make sure you have put the correct parameters)

To run the HTML:

1.	Open the HTML file “sipphone.html” 
2.	Test the applet.
We tried ways to make it work. The applet registers but gives an access control error. Good luck fixing it. To see the error you can look at the java console available in tools in Firefox or internet explorer.  






Errors FAQ:
You might need to sign the jar file to be able to access the Asterisk server. Java security does not allow applets to access remote servers if it did not originate from there. Since you are loading the applet from your directory, you might get security errors if you don't sign the applet.
Instruction to sign the applet is at 
http://forum.java.sun.com/thread.jspa?threadID=174214

For making your distribution, I think the easiest thing to do is to 
get the all java version of JMF, unjar it locally using: 
  jar -xf jmf.jar 
Also unjar the Flibble jar(s) and flibble dependencies into the same 
directory. 
Then, add your .class files to the tree, and, don't forget to put 
jmf.properties into the root. 
Then, re-jar the entire tree, using jar -cf 
Adding it to your web page, should be simple - just use the applet tag 
and specify your applet's code base. 
Good luck! 



eg

jar xf concurrent.jar
jar xf nist-sdp-1.0.jar
jar xf sip-sdp.jar
jar xf jmf.jar
jar xf log4j-1.2.8.jar
 
jar cf SipPhoneApplet.jar *.class com de codecLib EDU gov javax jmapps org jmf.properties
 
jarsigner SipPhoneApplet.jar <your-test-key>
jarsigner JainSipApi...
jarsigner JainSipRi...
jarsigner jarkarta...
jarsigner jstun....
 
Then click on sipphone.html

