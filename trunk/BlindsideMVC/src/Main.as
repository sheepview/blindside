// ActionScript file
import mx.collections.XMLListCollection;

private var menubarXML:XMLList =
                <>
                    <menuitem label="Menu1">
                        <menuitem label="Debug" data="1A"/>
                        <menuitem label="MenuItem 1-B" data="1B"/>
                    </menuitem>
                    <menuitem label="Menu2">
                        <menuitem label="MenuItem 2-A" type="check"  data="2A"/>
                        <menuitem type="separator" />
                        <menuitem label="MenuItem 2-B" >
                            <menuitem label="SubMenuItem 3-A" type="radio"
                                groupName="one" data="3A"/>
                            <menuitem label="SubMenuItem 3-B" type="radio"
                                groupName="one" data="3B"/>
                        </menuitem>
                    </menuitem>
                </>;
                
import flexlib.mdi.effects.effectsLib.MDIVistaEffects;
import mx.events.MenuEvent;
import util.log.LogWindow;       
         
[Bindable]
public var menuBarCollection:XMLListCollection

private var logWindow:LogWindow;

public function init():void{
	menuBarCollection = new XMLListCollection(menubarXML);
}

public function menuHandler(e:MenuEvent):void{
	if (e.item.@label == "Debug"){
		popupLogWindow();
	} 
}

private function popupLogWindow():void{
	if (logWindow != null) return;
	
	logWindow = new LogWindow();
	logWindow.width = 600;
	logWindow.height = 280;
	logWindow.title = "Log";
	logWindow.showCloseButton = true;
	mdiCanvas.windowManager.add(logWindow);
	mdiCanvas.windowManager.absPos(logWindow, 700, 500);
}