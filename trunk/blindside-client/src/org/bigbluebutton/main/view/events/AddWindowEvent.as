package org.bigbluebutton.main.view.events
{

	import flash.events.Event;	
	import flexlib.mdi.containers.MDIWindow;

	public class AddWindowEvent extends Event
	{
		// The View Component to be added
		public var component:MDIWindow;
//		public var component:String;
		// The type of event
		public static const NAME:String = 'ADD_WINDOW';
			
		// Constructor
		public function AddWindowEvent( component:MDIWindow )
//		public function AddWindowEvent( component:String )
		{
			super( NAME, true );
			this.component = component;	
		}
		
	}
}