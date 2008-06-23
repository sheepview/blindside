package org.bigbluebutton.pbx.asterisk;

import org.asteriskjava.fastagi.AgiChannel;
import org.asteriskjava.fastagi.AgiException;
import org.asteriskjava.fastagi.AgiRequest;
import org.asteriskjava.fastagi.AgiScript;

import groovy.lang.Binding;
import groovy.sql.Sql;
import groovy.util.GroovyScriptEngine;
import groovy.util.ResourceException;
import groovy.util.ScriptException;

import java.io.IOException;
import java.sql.SQLException;
import javax.sql.DataSource;

import Conference;

class AsteriskAgi implements AgiScript {

    private GroovyScriptEngine gse
    private Sql db
    
    private DataSource dataSource
    private String scriptsLocation
    private int tries = 0
    	
    def void setDataSource(DataSource source) {
    	dataSource = source;
    	db = new Sql(dataSource);
    }
    
    def void setScriptsLocation(String location) {
    	scriptsLocation = location;
    	System.out.println("loc=" + scriptsLocation);
    	
    	try {
			this.gse = new GroovyScriptEngine(scriptsLocation);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    def void service(AgiRequest request, AgiChannel channel)
            throws AgiException {
        
        tries = 0
        boolean found = false
        while ((tries < 3).and(!found)) {
            
			def number = channel.getData("conf-getconfno", 10000, 10)
			println "you entered "
			println "$number"
		
			def conf = Conference.findByConferenceNumber(number)

			if (conf) { 
				println "found one! " + conf.conferenceName
				def pin = channel.getData("conf-getpin", 10000)
				println pin
				println conf.pin
				if (pin.toInteger() == conf.pin) {
					channel.streamFile("conf-placeintoconf")
					channel.exec("Meetme", "$number|dMq")
					found = true
				} else {
					channel.streamFile("conf-invalidpin")
				}
			} else {
				channel.streamFile("conf-invalid")
			}
			tries++
		}

/*
        String script;
        Binding binding;

        script = request.getScript();
        binding = new Binding();
        binding.setVariable("request", request);
        binding.setVariable("channel", channel);
        binding.setVariable("db", db);
        try
        {
        	System.out.println(script.toString());
            gse.run(script, binding);
        }
        catch (ResourceException e)
        {
            throw new AgiException("Unable to load groovy script '" + script + "'", e);
        }
        catch (ScriptException e)
        {
            throw new AgiException("Exception while running groovy script '" +
                    script + "'", e);
        }
*/
    } 

}