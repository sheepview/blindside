
package org.bigbluebutton.core.interfaces
{
	/**
	 * Interface for a Module.
	 * <P>
	 * This is the API that must be implemented by a
	 * Module. </P>
	 */
	public interface IModule
	{
		/**
		 * Get the Module's key. 
		 * <P> 
		 * This will be a unique string. Generally created
		 * by adding a unique URI for the module to the 
		 * id property of the IModule instance.</P>
		 */
		function getModuleKey( ):String;
		
		/**
		 * Set the Module's reference to the MessageBus.
		 * <P>
		 * The Module communicates with the rest of the
		 * application via the MessageBus.  
		 */		
		function setMessageBus( bus : MessageBus ) : void;
	}
}