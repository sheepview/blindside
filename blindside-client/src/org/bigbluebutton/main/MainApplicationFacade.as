package org.bigbluebutton.main
{
	import org.bigbluebutton.main.controller.StartupCommand;
	import org.bigbluebutton.main.view.components.MainApplicationShell;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	public class MainApplicationFacade extends Facade implements IFacade
	{
		// Notification constants 
		public static const STARTUP:String = 'startup';
		public static const ADD_WINDOW1:String = 'addWindow';
		public static const REMOVE_WINDOW1:String = 'removeWindow';
				
		public function MainApplicationFacade(key:String)
		{
			super(key);
		}
		
        /**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance( key:String ) : MainApplicationFacade 
        {
            if ( instanceMap[ key ] == null ) instanceMap[ key ] = new MainApplicationFacade( key );
            return instanceMap[ key ] as MainApplicationFacade;
        }
        
	    /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
            super.initializeController();            
            registerCommand( STARTUP, StartupCommand );
        }
        
        /**
         * Application startup
         * 
         * @param app a reference to the application component 
         */  
        public function startup( app:MainApplicationShell ):void
        {
        	sendNotification( STARTUP, app );
        }		
	}
}