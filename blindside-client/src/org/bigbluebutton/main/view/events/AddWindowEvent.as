
package org.bigbluebutton.main.view.events
{
	import flash.events.Event;
	import flash.display.DisplayObject;

	public class AddWindowEvent extends Event
	{
		// The View Component to be added
		public var component:DisplayObject;
		
		// The type of event
		public static const NAME:String = 'addComponent';
			
		// Constructor
		public function AddWindowEvent( component:DisplayObject )
		{
			super( NAME, true );
			this.component = component;	
		}
		
	}
}