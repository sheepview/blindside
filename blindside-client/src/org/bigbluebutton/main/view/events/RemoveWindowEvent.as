
package org.bigbluebutton.main.view.events
{
	import flash.events.Event;
	import flash.display.DisplayObject;

	public class RemoveWindowEvent extends Event
	{
		// The View Component to be removed
		public var component:DisplayObject;
		
		// The type of event
		public static const NAME:String = 'removeComponent';
			
		// Constructor
		public function RemoveWindowEvent( component:DisplayObject )
		{
			super( NAME, true );
			this.component = component;	
		}
		
	}
}