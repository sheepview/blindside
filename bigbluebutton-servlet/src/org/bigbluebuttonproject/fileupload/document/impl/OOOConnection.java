package org.bigbluebuttonproject.fileupload.document.impl;

import com.sun.star.lang.XComponent;
import com.sun.star.lang.XMultiComponentFactory;

public class OOOConnection {
    
    //private String strBridgeName;
    private XMultiComponentFactory componentFactory;
    private XComponent bridge;
    
    public OOOConnection(
                //String strBridgeName, 
                XComponent bridge,
                XMultiComponentFactory componentFactory
                ){
        //this.strBridgeName = strBridgeName;
        this.componentFactory = componentFactory;
        this.bridge = bridge;
    }
    /*
    public String getBridgeName(){
        return this.strBridgeName;
    }
     **/
    
    public XComponent getBridge(){
        return this.bridge;
    }
    
    public XMultiComponentFactory getComponentFactory(){
        return this.componentFactory;
    }
    
}
