package org.bigbluebutton.common
{
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Pipe;
	
	/**
	 * This class is used by the module to send messages to the Router.
	 */
	public class OutputPipe implements IPipeFitting
	{
		private var NAME : String;
		
		// Pipe used to receive messages from the module.
		private var input : Pipe = new Pipe();
		
		public function OutputPipe(name : String)
		{
			NAME = name;
		}

		public function get name() : String
		{
			return NAME;
		}
		
		public function connect( output:IPipeFitting ) : Boolean
		{
			return input.connect(output);
		}
		
		public function disconnect( ) : IPipeFitting
		{
			return input.disconnect();
		}
		
		/**
		 * To send a message, add a header with SRC and TO fields as a convention.
		 * The Router will look at the TO field and routes the message to the
		 * correct inputpipe for a module.
		 * e.g. 			// create a message
   		 *	var messageToSend:IPipeMessage = new Message( Message.NORMAL, 
   		 *											      { SRC:'MAININPUT', TO: 'LOGGERINPUT' },
   		 *												  new XML(<testMessage testAtt='Hello'/>),
   		 *											      Message.PRIORITY_HIGH );
		 */		
		public function write( message:IPipeMessage ) : Boolean
		{
			return input.write(message);
		}
	}
}