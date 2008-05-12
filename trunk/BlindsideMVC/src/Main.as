// ActionScript file
import mx.collections.XMLListCollection;

private var menubarXML:XMLList =
                <>
                    <menuitem label="File">
                        <menuitem label="LogOut"/> 
                    </menuitem>
                    <menuitem label="Components">
                        <menuitem label="Chat"/>
                        <menuitem label="Audio"/>
                        <menuitem label="Video"/>
                        <menuitem label="Presentation"/>
                        <menuitem label="Whiteboard"/>
                        <menuitem type="separator"/>
                        <menuitem label="Debug"/>
                    </menuitem>
                    <menuitem label="Layout" >
						<menuitem label="Tile" />
						<menuitem label="Cascade" />
                    </menuitem>
                </>;
                
import flexlib.mdi.effects.effectsLib.MDIVistaEffects;
import mx.events.MenuEvent;
import util.log.LogWindow;       
import flash.system.Capabilities;
import util.log.Logger;
import util.log.LoggerModelLocator;
import mx.controls.Alert;
import login.LogInFacade;
import login.view.LogIn;
import mx.styles.StyleManager;
import flash.net.URLRequest;
import flash.net.navigateToURL;
import mx.events.CloseEvent;
import whiteboard.BoardFacade;
import whiteboard.view.Board;
         
[Bindable]
public var menuBarCollection:XMLListCollection

private var logWindow:LogWindow;
private var log:Logger = LoggerModelLocator.getInstance().log;

private var cssURL:String;

//Here add facade variables for each component
private var loginFacade:LogInFacade = LogInFacade.getInstance();
private var whiteboardFacade:BoardFacade;

//Here add GUI modules for your components
public var whiteboard:Board;

public function init():void{
	menuBarCollection = new XMLListCollection(menubarXML);
	checkFlashVersion();
	loginFacade.startup(this);
}

public function menuHandler(e:MenuEvent):void{
	if (e.item.@label == "Debug"){
		popupLogWindow();
	}
	else if (e.item.@label == "Version"){
		checkCapabilities();
	} else if (e.item.@label == "Tile"){
		mdiCanvas.windowManager.tile();
	} else if (e.item.@label == "Cascade"){
		mdiCanvas.windowManager.cascade();
	} else if (e.item.@label == "Whiteboard"){
		popupWhiteboard();
	}
}

private function popupLogWindow():void{
	//if (logWindow != null) return;
	
	logWindow = new LogWindow();
	logWindow.width = 600;
	logWindow.height = 280;
	logWindow.title = "Log";
	logWindow.showCloseButton = true;
	mdiCanvas.windowManager.add(logWindow);
	mdiCanvas.windowManager.absPos(logWindow, 700, 500);
}

private function popupWhiteboard():void{
	whiteboard = new Board();
	this.whiteboardFacade = BoardFacade.getInstance();
}

//private function popupLogin

private function checkFlashVersion():void{
	if (Number(Capabilities.version.substr(4,1)) < 9){
		Alert.show("You are using FlashPlayer v." + Capabilities.version.substr(4,7) +
		 ". Please upgrade to the newest version","Warning",Alert.OK,this,downloadFlash);
	}
}

private function downloadFlash(eventObject:CloseEvent):void{
	var urlRequest:URLRequest = 
		new URLRequest("http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash");
	navigateToURL(urlRequest, "_top");
}

private function checkCapabilities():void{
	log.info("Flash Player Version: " + Capabilities.version);
	log.info("Operating System: " + Capabilities.os);
	log.info("Player Type: " + Capabilities.playerType);
	log.info("Language: " + Capabilities.language);
	log.info("Resolution: " + Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY);
}