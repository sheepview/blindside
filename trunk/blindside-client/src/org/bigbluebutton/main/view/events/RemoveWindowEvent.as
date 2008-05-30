
package org.bigbluebutton.main.view.events
{
	import flash.events.Event;
	import flexlib.mdi.containers.MDIWindow;

	public class RemoveWindowEvent extends Event
	{
		// The View Component to be removed
		public var component:MDIWindow;
		
		// The type of event
		public static const NAME:String = 'removeComponent';
			
		// Constructor
		public function RemoveWindowEvent( component:MDIWindow )
		{
			super( NAME, true );
			this.component = component;	
		}
		
	}
}