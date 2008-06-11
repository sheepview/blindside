package org.bigbluebuttonproject.fileupload.document.impl;

import com.sun.star.lang.XComponent;
import com.sun.star.uno.XComponentContext;

public class OOODocument {
    
    private XComponent comp;
    private XComponentContext context;

    public OOODocument(XComponent comp, XComponentContext context) {
        this.comp = comp;
        this.context = context;
    }
    
    public XComponent getComponent(){
        return this.comp;
    }
    
    public XComponentContext getContext(){
        return this.context;
    }
    
}