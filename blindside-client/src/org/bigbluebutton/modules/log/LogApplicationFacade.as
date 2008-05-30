package org.bigbluebutton.modules.log
{
	import org.bigbluebutton.modules.log.controller.StartupCommand;
	import org.bigbluebutton.modules.log.view.components.LogModule;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;

	public class LogApplicationFacade extends Facade implements IFacade
	{
		public static const MODULE_STARTED:String        = "moduleStarted";
		public static const ADD_WINDOW:String        = "ADD_WINDOW";
		public static const REMOVE_WINDOW:String     = "REMOVE_WINDOW";
		public static const STARTUP:String        = "startup";
		public static const CLEAR:String          = "clear";
		public static const DEBUG:String	      = "debug";
		public static const WARN:String	          = "warn";
		public static const INFO:String	          = "info";
		public static const ERROR:String	      = "error";
		
		public function LogApplicationFacade( key:String )
		{
			super(key);	
		}

        /**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance( key:String ) : LogApplicationFacade 
        {
            if ( instanceMap[ key ] == null ) instanceMap[ key ]  = new LogApplicationFacade( key );
            return instanceMap[ key ] as LogApplicationFacade;
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
        public function startup( app:LogModule ):void
        {
        	sendNotification( STARTUP, app );
        }
		
	}
}