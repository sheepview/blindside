package org.bigbluebutton.core.interfaces
{
	import org.bigbluebutton.main.view.components.MainApplicationShell;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.PipeListener;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.TeeMerge;
	
	/**
	 * The Router is responsible for routing messages between cores/modules
	 * in the BigBlueButton system.
	 * 
	 * Modules register an InputPipe where it wants to receive messages and
	 * an OutputPipe where it uses to send messages to other modules. 
	 */ 
	public class Router
	{
		// Listens from messages from the core and routes messages.
		private var inputMessageRouter : PipeListener;
		
		// Mergers all OutputPipes from the modules so that the Router
		// will have only one listener.
		//    outpipe --->|
		//    outpipe --->|---> listener ---> inputpipe
		//    outpipe --->|
		//
		private var teeMerge:TeeMerge = new TeeMerge( );
		
		// Stores all our INPUT and OUTPUT Pipes
		private var junction : Junction = new Junction();
		
		private var rshell : MainApplicationShell;
		
		public function Router(shell : MainApplicationShell = null)
		{
			rshell = shell;
			inputMessageRouter = new PipeListener(this, routeMessage);
			teeMerge.connect(inputMessageRouter);
		}
		
		/**
		 * Register an InputPipe to receive a message from the Router.
		 */
		public function registerInputPipe(name : String, pipe: IPipeFitting) : void
		{
			// Register the pipe as an OUTPUT because the Router will use this
			// pipe to send OUT to the module.
			junction.registerPipe(name, Junction.OUTPUT, pipe);
		}
		
		/**
		 * Register an OutputPipe to send a message to other modules through the Router.
		 */
		public function registerOutputPipe(name : String, pipe: IPipeFitting) : void
		{
			// Register the pipe as an INPUT because the Router will use this
			// pipe to receive messages from the module.
			junction.registerPipe(name, Junction.INPUT, pipe);
			teeMerge.connectInput(pipe);
		}
		
		/**
		 * Routes the message using the TO field in the Message Header.
		 * The TO field contains the name of the INPUT Pipe.
		 */
		private function routeMessage(message:IPipeMessage):void
		{
			rshell.debugLog.text = 'routing message to ' + message.getHeader().TO;
			
			var TO : String = message.getHeader().TO;
			var haspipe : Boolean = junction.hasOutputPipe(TO);
			rshell.debugLog.text = 'There is a pipe with name ' + message.getHeader().TO + haspipe;
			var success: Boolean = junction.sendMessage(TO, message);
			rshell.debugLog.text = 'routing message to ' + message.getHeader().TO + success;
		}
	}
}