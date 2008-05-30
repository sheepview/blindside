package org.bigbluebutton.main.view
{
	import flexlib.mdi.containers.MDIWindow;
	
	import org.bigbluebutton.main.view.components.MainApplicationShell;
	import org.bigbluebutton.main.view.events.AddWindowEvent;
	import org.bigbluebutton.main.view.events.RemoveWindowEvent;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class MainApplicationShellMediator extends Mediator
	{
		public static const NAME:String = 'MainApplicationShellMediator';
		
		public function MainApplicationShellMediator( viewComponent:MainApplicationShell )
		{
			super( NAME, viewComponent );
			shell.addEventListener( AddWindowEvent.NAME, onAddWindow );
			shell.addEventListener( RemoveWindowEvent.NAME, onRemoveWindow );
		}

		/**
		 * A module has requested a MDIWindow be added to the MDICanvas
		 */
		protected function onAddWindow( event:AddWindowEvent ):void
		{
			shell.mdiCanvas.windowManager.add( event.component as MDIWindow);
		}	
		
		/**
		 * A module has requested a MDIWindow be removed from the MDICanvas
		 */
		protected function onRemoveWindow( event:RemoveWindowEvent ):void
		{
			shell.mdiCanvas.windowManager.remove( event.component as MDIWindow);
		}	
				
		protected function get shell():MainApplicationShell
		{
			return viewComponent as MainApplicationShell;
		}
		
	}
}