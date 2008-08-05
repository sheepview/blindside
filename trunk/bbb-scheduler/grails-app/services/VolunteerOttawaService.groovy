import org.apache.commons.httpclient.*
import org.apache.commons.httpclient.auth.AuthScope
import org.apache.commons.httpclient.methods.*

public class VolunteerOttawaService {

    boolean transactional = true

	static final URL = "http://www.volunteerottawa.ca/vo-clean/ws.php"
	static final reply = """
	<sessionid>3ba9c30076797e7dc3bef88be5cbbefe</sessionid>
<userid>1110</userid>
<email>wow@crystalbaymedia.com</email>
<login>Conference</login>
<firstname></firstname>
<lastname></lastname>
<vologin>
</vologin>
"""

    private vologin(String sessionId, Closure callable) {
			
		// build the URL
		def url = "${URL}?sessionId=${sessionId}"
		
		def client = new HttpClient()
		
		def get = new GetMethod(url)
		
		client.executeMethod(get)
		
		callable( new XmlSlurper().parse(get.responseBodyAsStream) )  
//		callable( new XmlSlurper().parse(reply) )  
    }
    
    def loginToVo(sessionId) {
    	vologin(sessionId) { xml ->
    	println xml
    	return xml
        }
    }
}
