package org.bigbluebutton.main.view
{
	import flexlib.mdi.containers.MDIWindow;
	
	import org.bigbluebutton.main.view.components.MainApplicationShell;
	import org.bigbluebutton.main.view.events.AddWindowEvent;
	import org.bigbluebutton.main.view.events.RemoveWindowEvent;
	import org.bigbluebutton.modules.log.view.components.LogWindow;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.bigbluebutton.main.view.components.LoginWindow;
	
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
		//	var window : MDIWindow = new LogWindow();
			var window : MDIWindow = event.component as MDIWindow;
			window.title = "Listeners";
			window.showCloseButton = false;
			shell.mdiCanvas.windowManager.add(window);
			shell.mdiCanvas.windowManager.absPos(window, 20, 250);
//			shell.logWindow.title = event.component;
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