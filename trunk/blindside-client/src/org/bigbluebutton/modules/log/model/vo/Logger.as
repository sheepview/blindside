package org.bigbluebutton.modules.log.model.vo
{
	import flash.system.Capabilities;
	
	public class Logger
	{
		[Bindable]
		/**
		 * Flash Player version number inc. debugger flag.
		*/		
		public var flashVersion : String;
		
		[Bindable]
		/**
		 * Log text displayed in the TextArea.
		*/		
		public var statusText : String = "";
		
		[Bindable]
		/**
		 * Enable/disable DEBUG messages
		 * 
		 * @default true
		*/		
		public var debugEnabled : Boolean = true;
		
		[Bindable]
		/**
		 * Enable/disable INFO messages
		 * 
		 * @default true
		*/		
		public var infoEnabled : Boolean = true;
		
		[Bindable]
		/**
		 * Enable/disable WARN messages
		 * 
		 * @default true
		*/		
		public var warnEnabled : Boolean = true;
		
		[Bindable]
		/**
		 * Enable/disable ERROR messages
		 * 
		 * @default true
		*/		
		public var errorEnabled : Boolean = true;
		
		[Bindable]
		public var debugMessage : String = "Debug";
		[Bindable]
		public var infoMessage : String = "Info";
		[Bindable]
		public var warnMessage : String = "Warn";
		[Bindable]
		public var errorMessage : String = "Error";
		
		/**
		 * 
		 * @param env
		 * @return 
		 */			
		public function Logger()
		{
			var platformVersion : String = Capabilities.version.substr( String( Capabilities.version ).lastIndexOf(" ") + 1 );
			var manufacturer : String = Capabilities.manufacturer;
			// Get Flash Player version info.
			flashVersion = "Using " + manufacturer + " Flash Player " + platformVersion;
			//
			if ( Capabilities.isDebugger ) 
			{
				// Add debugger info.
				flashVersion += " (Debugger)";
			}

			// Display Flash Player version.
			info( flashVersion);
		}
		
		/**
		 * Handle DEBUG message
		 * @param message to log
		 */
		public function debug(message : String):void
		{
			if (this.debugEnabled) logMessage("[DEBUG] " + message);
		}
		
		/**
		 * Log the message
		 * @param msg Status message to display.
		 */		
		private function logMessage( msg : String) : void 
		{
			var statusMessage : String = iso( new Date() ) + " - " + msg;

			statusText += statusMessage + "<br>";
		}

		/**
		 * Handle INFO message
		 * @param message to log
		 */	
		public function info(message : String):void
		{
			if (this.infoEnabled) logMessage("[INFO] " + message);
		}

		/**
		 * Handle WARN message
		 * @param message to log
		 */	
		public function warn(message : String):void
		{
			if (this.warnEnabled) logMessage("[WARN] " + message);
		}

		/**
		 * Handle WARN message
		 * @param message to log
		 */	
		public function error(message : String):void
		{
			if (this.errorEnabled) logMessage("[ERROR] " + message);
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 */		
		private function doubleDigits( value : Number ) : String 
		{
			if ( value > 9 ) 
			{
				return String( value );
			} 
			else 
			{ 
				return "0" + value;
			}
		}
		
		/**
		 * 
		 * @param value
		 * @return 
		 */		
		private function tripleDigits( value : Number ) : String 
		{
			var newStr : String = "";
			if ( value > 9 && value < 100 ) 
			{
				newStr = String( value ) + "0";
			} 
			else 
			{ 
				newStr = String( value ) + "00";
			}
			return newStr.substr( 0, 3 );
		}
		
		/**
		 * 
		 * @param date
		 * @return 
		 */		
		private function iso( date : Date ) : String 
		{
			return  doubleDigits( date.getHours() )
					+ ":"
					+ doubleDigits( date.getMinutes() )
					+ ":"
					+ doubleDigits( date.getSeconds() )
					+ ":"
					+ tripleDigits( date.getMilliseconds() );
		}
	}
}