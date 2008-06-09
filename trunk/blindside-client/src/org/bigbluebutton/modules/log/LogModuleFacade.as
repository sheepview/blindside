package org.bigbluebutton.modules.log
{
	import org.bigbluebutton.modules.log.controller.ClearCommand;
	import org.bigbluebutton.modules.log.controller.SetLevelCommand;
	import org.bigbluebutton.modules.log.controller.StartupCommand;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;

	public class LogModuleFacade extends Facade implements IFacade
	{
		public static const STARTUP:String        = 'STARTUP';
		// NO_LOG = 0; ERROR = 1; WARN = 2; INFO = 3; DEBUG = 4;
		public static const SET_LEVEL:String	  = 'SET_LEVEL'; 
		public static const CLEAR:String   		  = 'CLEAR';
				
		public function LogModuleFacade( key:String )
		{
			super(key);	
		}

        /**
         * Singleton ApplicationFacade Factory Method
         */
        public static function getInstance( key:String ) : LogModuleFacade 
        {
            if ( instanceMap[ key ] == null ) instanceMap[ key ]  = new LogModuleFacade( key );
            return instanceMap[ key ] as LogModuleFacade;
        }
        
	    /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
            super.initializeController();            
            registerCommand( STARTUP, StartupCommand );
            registerCommand( SET_LEVEL, SetLevelCommand );
            registerCommand( CLEAR, ClearCommand );
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