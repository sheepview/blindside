package org.blindsideproject.views.control.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flexlib.mdi.containers.MDIWindow;

	public class OpenWindowEvent extends CairngormEvent
	{
		public var window : MDIWindow;
		
		public function OpenWindowEvent(window:MDIWindow) : void
		{
			super(ViewEvents.OPEN_NEW_WINDOW_EVENT);
			this.window = window;
		}
	}
}