// ActionScript file
import mx.collections.XMLListCollection;

private var menubarXML:XMLList =
                <>
                    <menuitem label="File">
                        <menuitem label="LogOut"/> 
                    </menuitem>
                    <menuitem label="Components">
                        <menuitem label="Chat" type="check"/>
                        <menuitem label="Audio" type="check"/>
                        <menuitem label="Video" type="check"/>
                        <menuitem label="Presentation" type="check"/>
                        <menuitem type="separator" />
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
         
[Bindable]
public var menuBarCollection:XMLListCollection

private var logWindow:LogWindow;
private var log:Logger = LoggerModelLocator.getInstance().log;

private var style:String = "MacOS9.css";

//Here add facade variables for each component
private var loginFacade:LogInFacade = LogInFacade.getInstance();

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

private function closeLogWindow():void{
	logWindow.close();
	logWindow = null;
}

//private function popupLogin

private function checkFlashVersion():void{
	if (Number(Capabilities.version.substr(4,1)) < 9){
		Alert.show("You are using FlashPlayer v." + Capabilities.version.substr(4,7) +
		 ". If you experience problems please upgrade to the newest version");
	}
}

private function checkCapabilities():void{
	log.info("Flash Player Version: " + Capabilities.version);
	log.info("Operating System: " + Capabilities.os);
	log.info("Player Type: " + Capabilities.playerType);
	log.info("Language: " + Capabilities.language);
	log.info("Resolution: " + Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY);
}