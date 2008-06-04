package org.bigbluebutton.core.interfaces
{
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Pipe;
	
	/**
	 * The class is used by the module to receive messages from the Router.
	 */
	public class InputPipe implements IPipeFitting
	{
		private var NAME : String;
		
		// Pipe used to send message into the module.
		private var output : Pipe = new Pipe();
		
		public function InputPipe(name : String)
		{
			NAME = name;
		}
		
		public function get name() : String
		{
			return NAME;
		}
		
		/**
		 * Used by the router to send message into the module.
		 */
        public function write( message:IPipeMessage ) : Boolean
        {
            return output.write( message );
        }

		public function connect( listener:IPipeFitting ) : Boolean
		{
			return output.connect(listener);			
		}
		
		public function disconnect( ) : IPipeFitting
		{
			return output.disconnect();
		}
	}
}